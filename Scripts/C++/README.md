# LunaUX C++ API

runs the lunaux engine **locally**, inside your c++ process. unlike the
[luau api](../Luau) (which hits the server), this spins up an isolated cpython
and loads the engine into it, so it decompiles offline, no key, no internet.

two files here, same 3 methods (`Decompile` / `Disassemble` / `CFG`), pick one:

- [`LocalAPI.cpp`](./LocalAPI.cpp) — **local**, embeds the engine (what's below). offline, no key.
- [`HttpAPI.cpp`](./HttpAPI.cpp) — **http**, just hits the server like the c#/rust clients. no python/engine to ship, but needs internet. ([jump](#http-version))

- `Decompile(bytecode, options)` -> source
- `Disassemble(bytecode)` -> listing
- `CFG(bytecode)` -> json

## how it works (local, LocalAPI.cpp)

`Init()` starts a cpython in isolated mode (ignores the system python,
PYTHONPATH, site-packages... i set sys.path myself to `pylib`), loads
`luna.pyd / luna.so` from a path with importlib, and drops the GIL. each call takes the
GIL, runs the python function with the raw bytes and hands you back the string.

the interpreter is created at the C level, inside the exe. not a separate
`python.exe`.

## what you need

build:

- c++17 compiler
- python headers + lib matching the engine (win: `python313.lib` / linux:
  `python3-dev`). mismatch the version and it dies with `undefined symbol`.

next to the binary at runtime:

- `python313.dll` + `python3.dll` (win) / `libpython3.x.so` (linux)
- `pylib/` (python's `Lib/` + `DLLs/`, the stdlib)
- `luna.pyd` / `luna.so` (the engine)

## build

linux:

```bash
g++ LocalAPI.cpp -o lunaux_api -pthread $(python3-config --cflags --embed) $(python3-config --ldflags --embed)
```

windows (msvc):

```bat
cl LocalAPI.cpp /EHsc /std:c++17 /I "C:\...\Python313\include" /link /LIBPATH:"C:\...\Python313\libs" python313.lib
```

## usage

```cpp
LunaUXClient engine;
engine.Init("./pylib", "./module.pyd"); // luna.so on linux

std::string bc = read_file("script.luac"); // raw bytecode
std::string src = engine.Decompile(bc, { {"strip_comments", false} });
std::string dis = engine.Disassemble(bc);
std::string cfg = engine.CFG(bc); // json
```

python errors come back as `std::runtime_error`. create/destroy the engine on
the main thread; calls are thread-safe (one at a time, GIL).

## http version

[`HttpAPI.cpp`](./HttpAPI.cpp) is the easy route if you dont want to ship the
engine: it just posts to the server. needs [cpp-httplib](https://github.com/yhirose/cpp-httplib)
(one header) + openssl. install both with vcpkg:

```bash
vcpkg install cpp-httplib openssl
```

or just grab the single header next to `HttpAPI.cpp`:

```bash
curl -L -O https://raw.githubusercontent.com/yhirose/cpp-httplib/master/httplib.h
```

```cpp
LunaUXClient luna; // or LunaUXClient("https://your-host")
std::string bc = read_file("script.luac");
std::string src = luna.Decompile(bc, { {"useConst", true} });
std::string dis = luna.Disassemble(bc);
std::string cfg = luna.CFG(bc); // json
```

build (linux): `g++ HttpAPI.cpp -o luna_http -lssl -lcrypto` (point `-I` at your
httplib header). errors throw `std::runtime_error` with the server status + body.

## notes

- server scripts have no bytecode, nothing to decompile.
- no websocket on purpose: everything runs local (or plain http), nothing to
  stream to the server. the WS would only be needed to parse containers
  (.rbxl/.rbxm), which does need a session + key. that's a separate feature.