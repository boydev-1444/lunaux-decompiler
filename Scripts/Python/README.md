# LunaUX Python API

client for [lunaux-decompiler.dev](https://lunaux-decompiler.dev). same as the
[c#](../CSharp) / [rust](../Rust) ones: decompile / disassemble / cfg over https,
no key. **stdlib only**, no pip install — just `urllib` + `json` + `base64`.

one class, [`HttpAPI.py`](./HttpAPI.py):

- `decompile(bytecode, options=None)` -> source
- `disassemble(bytecode)` -> listing
- `cfg(bytecode)` -> json

## usage

```python
from HttpAPI import LunaUXClient

luna = LunaUXClient()

with open("script.luac", "rb") as f:
    bc = f.read() # raw bytecode (bytes)

src = luna.decompile(bc, {"useConst": True})
print(src)

dis = luna.disassemble(bc)
cfg = luna.cfg(bc) # json
```

## notes

- errors raise `LunaError` with `.status` + `.detail` (the server's message, e.g.
  `429` rate limited, `400` bad bytecode).
- point it elsewhere with `LunaUXClient("https://your-host")`.
- server scripts have no bytecode, nothing to decompile.
- same options as the [luau api](../Luau#options), docs on the
  [docs page](https://lunaux-decompiler.dev/documentation).

## local version

[`LocalAPI.py`](./LocalAPI.py) runs the engine **in your process**, offline, no key.
it loads `luna.pyd` / `luna.so` straight from its path with `importlib`, so
it needs the same python version the engine was built for (3.13).

```python
from LocalAPI import LunaUXClient

luna = LunaUXClient("./luna.pyd") # luna.so on linux
src = luna.decompile(bc, {"useConst": True})
dis = luna.disassemble(bc)
cfg = luna.cfg(bc) # json
```

errors raise `LunaError`.

## links

- web: [lunaux-decompiler.dev](https://lunaux-decompiler.dev)
- docs: [lunaux-decompiler.dev/documentation](https://lunaux-decompiler.dev/documentation)
- discord: [discord.gg/2mJUD4XDDT](https://discord.gg/2mJUD4XDDT)
