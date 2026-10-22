#define PY_SSIZE_T_CLEAN
#include <Python.h>
#include <string>
#include <map>
#include <mutex>
#include <stdexcept>

void add_path(PyConfig* cfg, const std::string& p) {
    wchar_t* w = Py_DecodeLocale(p.c_str(), nullptr);
    if (!w) 
        return;
    PyWideStringList_Append(&cfg->module_search_paths, w);
    PyMem_RawFree(w);
}

std::string fetch_error() {
    if (!PyErr_Occurred()) 
        return "";
    
    PyObject *t = nullptr, *v = nullptr, *tb = nullptr;
    PyErr_Fetch(&t, &v, &tb);
    PyErr_NormalizeException(&t, &v, &tb);

    std::string msg = "python error";
    if (v) {
        PyObject* s = PyObject_Str(v);

        if (s) {
            const char* c = PyUnicode_AsUTF8(s); 
            if (c) 
                msg = c; 
            Py_DECREF(s); 
        }
    }

    Py_XDECREF(t);
    Py_XDECREF(v);
    Py_XDECREF(tb);
    return msg;
}

class LunaUXClient {
public:
    LunaUXClient() = default;
    ~LunaUXClient() {
        if (!ready) return;
        PyEval_RestoreThread(main_state);
        Py_XDECREF(modul);
        Py_FinalizeEx();
    }
    LunaUXClient(const LunaUXClient&) = delete;
    LunaUXClient& operator=(const LunaUXClient&) = delete;

    void Init(std::string py_dir, std::string lunaPath) {

        // creating the python instance
        PyConfig config;
        PyConfig_InitIsolatedConfig(&config);
        config.site_import = 0;
        config.module_search_paths_set = 1;
        add_path(&config, py_dir + "/Lib");
        add_path(&config, py_dir + "/DLLs");
        add_path(&config, py_dir + "/Lib/site-packages");

        PyStatus st = Py_InitializeFromConfig(&config);
        PyConfig_Clear(&config);
        if (PyStatus_Exception(st))
            throw std::runtime_error(std::string("init failed: ") + (st.err_msg ? st.err_msg : "?"));

        modul = load_library(lunaPath);
        if (!modul) {
            std::string err = fetch_error();
            Py_FinalizeEx();
            throw std::runtime_error("could not load engine: " + err);
        }

        ready = true;
        main_state = PyEval_SaveThread();
    }

    std::string Decompile(const std::string& bytecode, const std::map<std::string, bool>& options = {}) {
        return call("decompile_bytecode", bytecode, &options);
    }
    std::string Disassemble(const std::string& bytecode) {
        return call("disassemble_bytecode", bytecode, nullptr);
    }
    std::string CFG(const std::string& bytecode) {
        return call("generate_cfg", bytecode, nullptr);
    }


private:
    PyObject* modul = nullptr;
    PyThreadState* main_state = nullptr;
    bool ready = false;
    std::mutex mtx;

    PyObject* load_library(const std::string& path) {
        // this sould work
        PyObject* util = PyImport_ImportModule("importlib.util");
        if (!util) 
            return nullptr;

        PyObject* spec = PyObject_CallMethod(util, "spec_from_file_location", "ss", "luna", path.c_str());
        Py_DECREF(util);

        if (!spec || spec == Py_None) {
            Py_XDECREF(spec);
            return nullptr;
        }

        PyObject* util2 = PyImport_ImportModule("importlib.util");
        PyObject* mod = util2 ? PyObject_CallMethod(util2, "module_from_spec", "O", spec) : nullptr;
        Py_XDECREF(util2);

        if (!mod) {
            Py_DECREF(spec);
            return nullptr;
        }

        PyObject* loader = PyObject_GetAttrString(spec, "loader");
        Py_DECREF(spec);

        PyObject* ran = loader ? PyObject_CallMethod(loader, "exec_module", "O", mod) : nullptr;
        Py_XDECREF(loader);

        if (!ran) { 
            Py_DECREF(mod);
            return nullptr;
        }

        Py_DECREF(ran);
        return mod;
    };

    std::string call(const char* func, const std::string& bytecode, const std::map<std::string, bool>* options) {
        // bro idk if ts works i forgot the python c api
        std::lock_guard<std::mutex> lk(mtx);
        if (!ready) 
            throw std::runtime_error("engine not started");

        PyGILState_STATE gil = PyGILState_Ensure();
        std::string out, err;

        PyObject* fn = PyObject_GetAttrString(modul, func);
        if (!fn || !PyCallable_Check(fn)) {
            Py_XDECREF(fn);
            PyGILState_Release(gil);
            throw std::runtime_error(std::string("engine has no function '") + func + "'");
        }

        PyObject* data = PyBytes_FromStringAndSize(bytecode.data(), (Py_ssize_t)bytecode.size());
        PyObject* args;
        if (options) {
            PyObject* opts = PyDict_New();
            for (auto& [k, v] : *options)
                PyDict_SetItemString(opts, k.c_str(), v ? Py_True : Py_False);
            
            args = PyTuple_Pack(2, data, opts);
            Py_DECREF(opts);
        } else {
            args = PyTuple_Pack(1, data);
        }
        Py_DECREF(data);

        PyObject* res = PyObject_CallObject(fn, args);
        Py_DECREF(fn);
        Py_DECREF(args);

        if (!res) {
            err = fetch_error();
        } else {
            if (PyUnicode_Check(res)) {
                const char* c = PyUnicode_AsUTF8(res);
                if (c) 
                    out = c;
            } else if (PyBytes_Check(res)) {
                out.assign(PyBytes_AsString(res), (size_t)PyBytes_Size(res));
            } else {
                PyObject* s = PyObject_Str(res);
                if (s) { 
                    const char* c = PyUnicode_AsUTF8(s); 
                    if (c) 
                        out = c;
                    Py_DECREF(s); 
                }
            }

            Py_DECREF(res);
        }
        PyGILState_Release(gil);
        if (!err.empty()) 
            throw std::runtime_error(err);
        return out;
    }

};