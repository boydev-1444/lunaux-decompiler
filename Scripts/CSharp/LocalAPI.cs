#nullable enable
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Text;

namespace LunaUX.Local;

public class LunaUXLocalException : Exception {
    public LunaUXLocalException(string message) : base(message) { }
}

// the bits of the cpython c api we use raaaaaaah
static unsafe class Python {
    static IntPtr lib;

    public static void Load(string path) {
        if (!NativeLibrary.TryLoad(path, out lib))
            throw new LunaUXLocalException("could not load " + path);
        Py_DecodeLocale = (delegate* unmanaged[Cdecl]<byte*, nuint*, IntPtr>)Get("Py_DecodeLocale");
        PyMem_RawFree = (delegate* unmanaged[Cdecl]<IntPtr, void>)Get("PyMem_RawFree");
        Py_SetPath = (delegate* unmanaged[Cdecl]<IntPtr, void>)Get("Py_SetPath");
        Py_InitializeEx = (delegate* unmanaged[Cdecl]<int, void>)Get("Py_InitializeEx");
        Py_FinalizeEx = (delegate* unmanaged[Cdecl]<int>)Get("Py_FinalizeEx");
        PyEval_SaveThread = (delegate* unmanaged[Cdecl]<IntPtr>)Get("PyEval_SaveThread");
        PyEval_RestoreThread = (delegate* unmanaged[Cdecl]<IntPtr, void>)Get("PyEval_RestoreThread");
        PyGILState_Ensure = (delegate* unmanaged[Cdecl]<int>)Get("PyGILState_Ensure");
        PyGILState_Release = (delegate* unmanaged[Cdecl]<int, void>)Get("PyGILState_Release");
        PyImport_ImportModule = (delegate* unmanaged[Cdecl]<byte*, IntPtr>)Get("PyImport_ImportModule");
        PyObject_GetAttrString = (delegate* unmanaged[Cdecl]<IntPtr, byte*, IntPtr>)Get("PyObject_GetAttrString");
        PyObject_CallObject = (delegate* unmanaged[Cdecl]<IntPtr, IntPtr, IntPtr>)Get("PyObject_CallObject");
        PyCallable_Check = (delegate* unmanaged[Cdecl]<IntPtr, int>)Get("PyCallable_Check");
        Py_IncRef = (delegate* unmanaged[Cdecl]<IntPtr, void>)Get("Py_IncRef");
        Py_DecRef = (delegate* unmanaged[Cdecl]<IntPtr, void>)Get("Py_DecRef");
        PyUnicode_FromString = (delegate* unmanaged[Cdecl]<byte*, IntPtr>)Get("PyUnicode_FromString");
        PyUnicode_AsUTF8AndSize = (delegate* unmanaged[Cdecl]<IntPtr, nint*, byte*>)Get("PyUnicode_AsUTF8AndSize");
        PyBytes_FromStringAndSize = (delegate* unmanaged[Cdecl]<byte*, nint, IntPtr>)Get("PyBytes_FromStringAndSize");
        PyTuple_New = (delegate* unmanaged[Cdecl]<nint, IntPtr>)Get("PyTuple_New");
        PyTuple_SetItem = (delegate* unmanaged[Cdecl]<IntPtr, nint, IntPtr, int>)Get("PyTuple_SetItem");
        PyDict_New = (delegate* unmanaged[Cdecl]<IntPtr>)Get("PyDict_New");
        PyDict_SetItemString = (delegate* unmanaged[Cdecl]<IntPtr, byte*, IntPtr, int>)Get("PyDict_SetItemString");
        PyBool_FromLong = (delegate* unmanaged[Cdecl]<nint, IntPtr>)Get("PyBool_FromLong");
        PyErr_Occurred = (delegate* unmanaged[Cdecl]<IntPtr>)Get("PyErr_Occurred");
        PyErr_Fetch = (delegate* unmanaged[Cdecl]<IntPtr*, IntPtr*, IntPtr*, void>)Get("PyErr_Fetch");
        PyErr_Clear = (delegate* unmanaged[Cdecl]<void>)Get("PyErr_Clear");
        PyObject_Str = (delegate* unmanaged[Cdecl]<IntPtr, IntPtr>)Get("PyObject_Str");
    }

    static IntPtr Get(string name) {
        if (!NativeLibrary.TryGetExport(lib, name, out var p))
            throw new LunaUXLocalException("python symbol missing: " + name);
        return p;
    }

    public static delegate* unmanaged[Cdecl]<byte*, nuint*, IntPtr> Py_DecodeLocale;
    public static delegate* unmanaged[Cdecl]<IntPtr, void> PyMem_RawFree;
    public static delegate* unmanaged[Cdecl]<IntPtr, void> Py_SetPath;
    public static delegate* unmanaged[Cdecl]<int, void> Py_InitializeEx;
    public static delegate* unmanaged[Cdecl]<int> Py_FinalizeEx;
    public static delegate* unmanaged[Cdecl]<IntPtr> PyEval_SaveThread;
    public static delegate* unmanaged[Cdecl]<IntPtr, void> PyEval_RestoreThread;
    public static delegate* unmanaged[Cdecl]<int> PyGILState_Ensure;
    public static delegate* unmanaged[Cdecl]<int, void> PyGILState_Release;
    public static delegate* unmanaged[Cdecl]<byte*, IntPtr> PyImport_ImportModule;
    public static delegate* unmanaged[Cdecl]<IntPtr, byte*, IntPtr> PyObject_GetAttrString;
    public static delegate* unmanaged[Cdecl]<IntPtr, IntPtr, IntPtr> PyObject_CallObject;
    public static delegate* unmanaged[Cdecl]<IntPtr, int> PyCallable_Check;
    public static delegate* unmanaged[Cdecl]<IntPtr, void> Py_IncRef;
    public static delegate* unmanaged[Cdecl]<IntPtr, void> Py_DecRef;
    public static delegate* unmanaged[Cdecl]<byte*, IntPtr> PyUnicode_FromString;
    public static delegate* unmanaged[Cdecl]<IntPtr, nint*, byte*> PyUnicode_AsUTF8AndSize;
    public static delegate* unmanaged[Cdecl]<byte*, nint, IntPtr> PyBytes_FromStringAndSize;
    public static delegate* unmanaged[Cdecl]<nint, IntPtr> PyTuple_New;
    public static delegate* unmanaged[Cdecl]<IntPtr, nint, IntPtr, int> PyTuple_SetItem;
    public static delegate* unmanaged[Cdecl]<IntPtr> PyDict_New;
    public static delegate* unmanaged[Cdecl]<IntPtr, byte*, IntPtr, int> PyDict_SetItemString;
    public static delegate* unmanaged[Cdecl]<nint, IntPtr> PyBool_FromLong;
    public static delegate* unmanaged[Cdecl]<IntPtr> PyErr_Occurred;
    public static delegate* unmanaged[Cdecl]<IntPtr*, IntPtr*, IntPtr*, void> PyErr_Fetch;
    public static delegate* unmanaged[Cdecl]<void> PyErr_Clear;
    public static delegate* unmanaged[Cdecl]<IntPtr, IntPtr> PyObject_Str;
}

public sealed unsafe class LunaUXClient : IDisposable {
    readonly object mtx = new();
    IntPtr engine;
    IntPtr mainState;
    bool ready;

    public LunaUXClient(string pythonLib, string pyDir, string enginePath) {
        Python.Load(pythonLib);
        char sep = OperatingSystem.IsWindows() ? ';' : ':';
        string path = $"{pyDir}/Lib{sep}{pyDir}/DLLs{sep}{pyDir}/Lib/site-packages";
        IntPtr wide;
        fixed (byte* p = Cstr(path))
            wide = Python.Py_DecodeLocale(p, null);
        if (wide == IntPtr.Zero)
            throw new LunaUXLocalException("could not decode python path");
        Python.Py_SetPath(wide);
        Python.Py_InitializeEx(0);
        Python.PyMem_RawFree(wide);

        try {
            engine = LoadEngine(enginePath);
        }
        catch {
            Python.Py_FinalizeEx();
            throw;
        }

        ready = true;
        mainState = Python.PyEval_SaveThread();
    }

    public string Decompile(byte[] bytecode, IDictionary<string, bool>? options = null) =>
        Call("decompile_bytecode", bytecode, options ?? new Dictionary<string, bool>());

    public string Disassemble(byte[] bytecode) => Call("disassemble_bytecode", bytecode, null);

    public string CFG(byte[] bytecode) => Call("generate_cfg", bytecode, null);

    string Call(string func, byte[] bytecode, IDictionary<string, bool>? options) {
        lock (mtx) {
            if (!ready)
                throw new LunaUXLocalException("engine not started");

            int gil = Python.PyGILState_Ensure();
            try {
                IntPtr fn;
                fixed (byte* name = Cstr(func))
                    fn = Python.PyObject_GetAttrString(engine, name);
                if (fn == IntPtr.Zero || Python.PyCallable_Check(fn) == 0) {
                    Python.PyErr_Clear();
                    if (fn != IntPtr.Zero)
                        Python.Py_DecRef(fn);
                    throw new LunaUXLocalException($"engine has no function '{func}'");
                }

                IntPtr data;
                fixed (byte* b = bytecode)
                    data = Python.PyBytes_FromStringAndSize(b, bytecode.Length);

                IntPtr args = Python.PyTuple_New(options != null ? 2 : 1);
                Python.PyTuple_SetItem(args, 0, data);
                if (options != null) {
                    IntPtr dict = Python.PyDict_New();
                    foreach (var (k, v) in options) {
                        IntPtr b = Python.PyBool_FromLong(v ? 1 : 0);
                        fixed (byte* key = Cstr(k))
                            Python.PyDict_SetItemString(dict, key, b);
                        Python.Py_DecRef(b);
                    }
                    Python.PyTuple_SetItem(args, 1, dict);
                }

                IntPtr res = Python.PyObject_CallObject(fn, args);
                Python.Py_DecRef(fn);
                Python.Py_DecRef(args);
                if (res == IntPtr.Zero)
                    throw new LunaUXLocalException(FetchError());

                string text = ToStr(res);
                Python.Py_DecRef(res);
                return text;
            }
            finally {
                Python.PyGILState_Release(gil);
            }
        }
    }

    static IntPtr LoadEngine(string path) {
        IntPtr util;
        fixed (byte* n = Cstr("importlib.util"))
            util = Python.PyImport_ImportModule(n);
        if (util == IntPtr.Zero)
            throw new LunaUXLocalException(FetchError());

        IntPtr makeSpec = Attr(util, "spec_from_file_location");
        IntPtr makeMod = Attr(util, "module_from_spec");
        Python.Py_DecRef(util);

        IntPtr spec = CallWith(makeSpec, Str("luna"), Str(path));
        Python.Py_DecRef(makeSpec);
        if (spec == IntPtr.Zero)
            throw new LunaUXLocalException("could not load engine: " + FetchError());

        Python.Py_IncRef(spec);
        IntPtr module = CallWith(makeMod, spec);
        Python.Py_DecRef(makeMod);
        if (module == IntPtr.Zero)
            throw new LunaUXLocalException("could not load engine: " + FetchError());

        IntPtr loader = Attr(spec, "loader");
        IntPtr exec = Attr(loader, "exec_module");
        Python.Py_IncRef(module);
        IntPtr ran = CallWith(exec, module);
        Python.Py_DecRef(exec);
        Python.Py_DecRef(loader);
        Python.Py_DecRef(spec);
        if (ran == IntPtr.Zero)
            throw new LunaUXLocalException("could not load engine: " + FetchError());
        Python.Py_DecRef(ran);
        return module;
    }

    static IntPtr Attr(IntPtr obj, string name) {
        fixed (byte* n = Cstr(name))
            return Python.PyObject_GetAttrString(obj, n);
    }

    static IntPtr Str(string s) {
        fixed (byte* p = Cstr(s))
            return Python.PyUnicode_FromString(p);
    }

    static IntPtr CallWith(IntPtr fn, params IntPtr[] items) {
        IntPtr args = Python.PyTuple_New(items.Length);
        for (int i = 0; i < items.Length; i++)
            Python.PyTuple_SetItem(args, i, items[i]);
        IntPtr res = Python.PyObject_CallObject(fn, args);
        Python.Py_DecRef(args);
        return res;
    }

    static string ToStr(IntPtr obj) {
        IntPtr s = Python.PyObject_Str(obj);
        if (s == IntPtr.Zero) {
            Python.PyErr_Clear();
            return "";
        }
        nint len;
        byte* c = Python.PyUnicode_AsUTF8AndSize(s, &len);
        string text = c == null ? "" : Encoding.UTF8.GetString(c, (int)len);
        Python.Py_DecRef(s);
        return text;
    }

    static string FetchError() {
        if (Python.PyErr_Occurred() == IntPtr.Zero)
            return "python error";
        IntPtr t, v, tb;
        Python.PyErr_Fetch(&t, &v, &tb);
        string msg = v == IntPtr.Zero ? "python error" : ToStr(v);
        foreach (var o in new[] { t, v, tb })
            if (o != IntPtr.Zero)
                Python.Py_DecRef(o);
        return msg;
    }

    static byte[] Cstr(string s) => Encoding.UTF8.GetBytes(s + "\0");

    public void Dispose() {
        if (!ready)
            return;
        ready = false;
        Python.PyEval_RestoreThread(mainState);
        Python.Py_DecRef(engine);
        Python.Py_FinalizeEx();
    }
}
