import importlib.util
import os

class LunaError(Exception):
    pass

class LunaUXClient:
    def __init__(self, module_path=None):
        if module_path is None:
            module_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "luna.pyd" if os.name == "nt" else "luna.so")
        if not os.path.isfile(module_path):
            raise LunaError(f"engine not found: {module_path}")

        spec = importlib.util.spec_from_file_location("luna", module_path)
        if spec is None or spec.loader is None:
            raise LunaError(f"unsupported file: {module_path}")
        try:
            self._engine = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(self._engine)
        except Exception as e:
            raise LunaError(f"could not load engine: {e}") from None

    def decompile(self, bytecode, options=None):
        return self._call("decompile_bytecode", bytecode, options or {})

    def disassemble(self, bytecode):
        return self._call("disassemble_bytecode", bytecode)

    def cfg(self, bytecode):
        return self._call("generate_cfg", bytecode)

    def _call(self, name, bytecode, *extra):
        fn = getattr(self._engine, name, None)
        if not callable(fn):
            raise LunaError(f"engine has no function '{name}'")
        try:
            out = fn(bytes(bytecode), *extra)
        except Exception as e:
            raise LunaError(str(e)) from None
        return out.decode("utf-8", "replace") if isinstance(out, bytes) else str(out)