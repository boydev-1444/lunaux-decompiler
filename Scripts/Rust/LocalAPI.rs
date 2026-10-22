use std::collections::BTreeMap;
use std::ffi::{c_char, c_int, c_long, c_void, CStr, CString};
use std::fmt;
use std::sync::Mutex;

use libloading::Library;

type Obj = *mut c_void;

#[derive(Debug)]
pub struct LunaError(pub String);

impl fmt::Display for LunaError {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        write!(f, "lunaux error: {}", self.0)
    }
}
impl std::error::Error for LunaError {}

fn err<T>(s: impl Into<String>) -> Result<T, LunaError> {
    Err(LunaError(s.into()))
}

// the bits of the cpython c api we use frfr
struct Api {
    py_decode_locale: unsafe extern "C" fn(*const c_char, *mut usize) -> *mut c_void,
    py_mem_raw_free: unsafe extern "C" fn(*mut c_void),
    py_set_path: unsafe extern "C" fn(*const c_void),
    py_initialize_ex: unsafe extern "C" fn(c_int),
    py_finalize_ex: unsafe extern "C" fn() -> c_int,
    eval_save_thread: unsafe extern "C" fn() -> *mut c_void,
    eval_restore_thread: unsafe extern "C" fn(*mut c_void),
    gil_ensure: unsafe extern "C" fn() -> c_int,
    gil_release: unsafe extern "C" fn(c_int),
    import_module: unsafe extern "C" fn(*const c_char) -> Obj,
    get_attr: unsafe extern "C" fn(Obj, *const c_char) -> Obj,
    call_object: unsafe extern "C" fn(Obj, Obj) -> Obj,
    callable_check: unsafe extern "C" fn(Obj) -> c_int,
    incref: unsafe extern "C" fn(Obj),
    decref: unsafe extern "C" fn(Obj),
    unicode_from_string: unsafe extern "C" fn(*const c_char) -> Obj,
    unicode_as_utf8: unsafe extern "C" fn(Obj) -> *const c_char,
    bytes_from_string_and_size: unsafe extern "C" fn(*const c_char, isize) -> Obj,
    tuple_new: unsafe extern "C" fn(isize) -> Obj,
    tuple_set_item: unsafe extern "C" fn(Obj, isize, Obj) -> c_int,
    dict_new: unsafe extern "C" fn() -> Obj,
    dict_set_item_string: unsafe extern "C" fn(Obj, *const c_char, Obj) -> c_int,
    bool_from_long: unsafe extern "C" fn(c_long) -> Obj,
    err_occurred: unsafe extern "C" fn() -> Obj,
    err_fetch: unsafe extern "C" fn(*mut Obj, *mut Obj, *mut Obj),
    err_clear: unsafe extern "C" fn(),
    object_str: unsafe extern "C" fn(Obj) -> Obj,
    _lib: Library,
}

macro_rules! sym {
    ($lib:expr, $name:literal) => {
        *$lib.get($name).map_err(|e| LunaError(format!("python symbol missing: {}", e)))?
    };
}

impl Api {
    unsafe fn load(python_lib: &str) -> Result<Api, LunaError> {
        let lib = Library::new(python_lib).map_err(|e| LunaError(format!("could not load {}: {}", python_lib, e)))?;
        Ok(Api {
            py_decode_locale: sym!(lib, b"Py_DecodeLocale\0"),
            py_mem_raw_free: sym!(lib, b"PyMem_RawFree\0"),
            py_set_path: sym!(lib, b"Py_SetPath\0"),
            py_initialize_ex: sym!(lib, b"Py_InitializeEx\0"),
            py_finalize_ex: sym!(lib, b"Py_FinalizeEx\0"),
            eval_save_thread: sym!(lib, b"PyEval_SaveThread\0"),
            eval_restore_thread: sym!(lib, b"PyEval_RestoreThread\0"),
            gil_ensure: sym!(lib, b"PyGILState_Ensure\0"),
            gil_release: sym!(lib, b"PyGILState_Release\0"),
            import_module: sym!(lib, b"PyImport_ImportModule\0"),
            get_attr: sym!(lib, b"PyObject_GetAttrString\0"),
            call_object: sym!(lib, b"PyObject_CallObject\0"),
            callable_check: sym!(lib, b"PyCallable_Check\0"),
            incref: sym!(lib, b"Py_IncRef\0"),
            decref: sym!(lib, b"Py_DecRef\0"),
            unicode_from_string: sym!(lib, b"PyUnicode_FromString\0"),
            unicode_as_utf8: sym!(lib, b"PyUnicode_AsUTF8\0"),
            bytes_from_string_and_size: sym!(lib, b"PyBytes_FromStringAndSize\0"),
            tuple_new: sym!(lib, b"PyTuple_New\0"),
            tuple_set_item: sym!(lib, b"PyTuple_SetItem\0"),
            dict_new: sym!(lib, b"PyDict_New\0"),
            dict_set_item_string: sym!(lib, b"PyDict_SetItemString\0"),
            bool_from_long: sym!(lib, b"PyBool_FromLong\0"),
            err_occurred: sym!(lib, b"PyErr_Occurred\0"),
            err_fetch: sym!(lib, b"PyErr_Fetch\0"),
            err_clear: sym!(lib, b"PyErr_Clear\0"),
            object_str: sym!(lib, b"PyObject_Str\0"),
            _lib: lib,
        })
    }
}

pub struct LunaUXClient {
    api: Api,
    engine: Obj,
    main_state: *mut c_void,
    lock: Mutex<()>,
}

// every python call goes through PyGILState_Ensure + the mutex
unsafe impl Send for LunaUXClient {}
unsafe impl Sync for LunaUXClient {}

impl LunaUXClient {
    pub fn new(python_lib: &str, py_dir: &str, engine_path: &str) -> Result<LunaUXClient, LunaError> {
        unsafe {
            let api = Api::load(python_lib)?;
            let sep = if cfg!(windows) { ";" } else { ":" };
            let path = format!("{0}/Lib{1}{0}/DLLs{1}{0}/Lib/site-packages", py_dir, sep);
            let cpath = CString::new(path).map_err(|e| LunaError(e.to_string()))?;
            let wide = (api.py_decode_locale)(cpath.as_ptr(), std::ptr::null_mut());
            if wide.is_null() {
                return err("could not decode python path");
            }
            (api.py_set_path)(wide);
            (api.py_initialize_ex)(0);
            (api.py_mem_raw_free)(wide);

            let engine = load_engine(&api, engine_path);
            let engine = match engine {
                Ok(m) => m,
                Err(e) => {
                    (api.py_finalize_ex)();
                    return Err(e);
                }
            };

            let main_state = (api.eval_save_thread)();
            Ok(LunaUXClient { api, engine, main_state, lock: Mutex::new(()) })
        }
    }

    pub fn decompile(&self, bytecode: &[u8], options: Option<&BTreeMap<String, bool>>) -> Result<String, LunaError> {
        let empty = BTreeMap::new();
        self.call("decompile_bytecode", bytecode, Some(options.unwrap_or(&empty)))
    }

    pub fn disassemble(&self, bytecode: &[u8]) -> Result<String, LunaError> {
        self.call("disassemble_bytecode", bytecode, None)
    }

    pub fn cfg(&self, bytecode: &[u8]) -> Result<String, LunaError> {
        self.call("generate_cfg", bytecode, None)
    }

    fn call(&self, func: &str, bytecode: &[u8], options: Option<&BTreeMap<String, bool>>) -> Result<String, LunaError> {
        let _guard = self.lock.lock().unwrap();
        let a = &self.api;
        let cfunc = CString::new(func).unwrap();
        unsafe {
            let gil = (a.gil_ensure)();
            let result = (|| {
                let f = (a.get_attr)(self.engine, cfunc.as_ptr());
                if f.is_null() || (a.callable_check)(f) == 0 {
                    (a.err_clear)();
                    if !f.is_null() {
                        (a.decref)(f);
                    }
                    return err(format!("engine has no function '{}'", func));
                }

                let data = (a.bytes_from_string_and_size)(bytecode.as_ptr() as *const c_char, bytecode.len() as isize);
                let args = (a.tuple_new)(if options.is_some() { 2 } else { 1 });
                (a.tuple_set_item)(args, 0, data);
                if let Some(opts) = options {
                    let d = (a.dict_new)();
                    for (k, v) in opts {
                        let ck = CString::new(k.as_str()).unwrap();
                        let b = (a.bool_from_long)(*v as c_long);
                        (a.dict_set_item_string)(d, ck.as_ptr(), b);
                        (a.decref)(b);
                    }
                    (a.tuple_set_item)(args, 1, d);
                }

                let res = (a.call_object)(f, args);
                (a.decref)(f);
                (a.decref)(args);
                if res.is_null() {
                    return err(fetch_error(a));
                }
                let out = obj_to_string(a, res);
                (a.decref)(res);
                Ok(out)
            })();
            (a.gil_release)(gil);
            result
        }
    }
}

impl Drop for LunaUXClient {
    fn drop(&mut self) {
        unsafe {
            (self.api.eval_restore_thread)(self.main_state);
            (self.api.decref)(self.engine);
            (self.api.py_finalize_ex)();
        }
    }
}

unsafe fn load_engine(a: &Api, path: &str) -> Result<Obj, LunaError> {
    let util = (a.import_module)(c"importlib.util".as_ptr());
    if util.is_null() {
        return err(fetch_error(a));
    }
    let make_spec = (a.get_attr)(util, c"spec_from_file_location".as_ptr());
    let make_mod = (a.get_attr)(util, c"module_from_spec".as_ptr());
    (a.decref)(util);

    let cpath = CString::new(path).map_err(|e| LunaError(e.to_string()))?;
    let args = (a.tuple_new)(2);
    (a.tuple_set_item)(args, 0, (a.unicode_from_string)(c"luna".as_ptr()));
    (a.tuple_set_item)(args, 1, (a.unicode_from_string)(cpath.as_ptr()));
    let spec = (a.call_object)(make_spec, args);
    (a.decref)(args);
    (a.decref)(make_spec);
    if spec.is_null() {
        return err(format!("could not load engine: {}", fetch_error(a)));
    }

    let args = (a.tuple_new)(1);
    (a.incref)(spec);
    (a.tuple_set_item)(args, 0, spec);
    let module = (a.call_object)(make_mod, args);
    (a.decref)(args);
    (a.decref)(make_mod);
    if module.is_null() {
        return err(format!("could not load engine: {}", fetch_error(a)));
    }

    let loader = (a.get_attr)(spec, c"loader".as_ptr());
    let exec = (a.get_attr)(loader, c"exec_module".as_ptr());
    let args = (a.tuple_new)(1);
    (a.incref)(module);
    (a.tuple_set_item)(args, 0, module);
    let ran = (a.call_object)(exec, args);
    (a.decref)(args);
    (a.decref)(exec);
    (a.decref)(loader);
    (a.decref)(spec);
    if ran.is_null() {
        return err(format!("could not load engine: {}", fetch_error(a)));
    }
    (a.decref)(ran);
    Ok(module)
}

unsafe fn obj_to_string(a: &Api, o: Obj) -> String {
    let s = (a.object_str)(o);
    if s.is_null() {
        (a.err_clear)();
        return String::new();
    }
    let text = CStr::from_ptr((a.unicode_as_utf8)(s)).to_string_lossy().into_owned();
    (a.decref)(s);
    text
}

unsafe fn fetch_error(a: &Api) -> String {
    if (a.err_occurred)().is_null() {
        return "python error".into();
    }
    let (mut t, mut v, mut tb): (Obj, Obj, Obj) = (std::ptr::null_mut(), std::ptr::null_mut(), std::ptr::null_mut());
    (a.err_fetch)(&mut t, &mut v, &mut tb);
    let msg = if v.is_null() { "python error".to_string() } else { obj_to_string(a, v) };
    for o in [t, v, tb] {
        if !o.is_null() {
            (a.decref)(o);
        }
    }
    msg
}