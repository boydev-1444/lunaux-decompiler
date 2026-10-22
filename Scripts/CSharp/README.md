# LunaUX C# API

.net client for [lunaux-decompiler.dev](https://lunaux-decompiler.dev). same deal
as the [luau http flavour](../Luau) but for c#: decompile / disassemble / cfg over
https, no key, no engine to ship. you pass raw luau bytecode, it base64s it and
hits the server.

one class, [`HttpAPI.cs`](./HttpAPI.cs). methods are sync and just return the string,
same as the c++ one:

- `Decompile(bytecode, options?, filename?)` -> source
- `Disassemble(bytecode, filename?)` -> listing
- `CFG(bytecode)` -> json

## requirements

- .net 6+ (uses `HttpClient` + `System.Text.Json`, both built in — no nuget deps)

## usage

```csharp
using LunaUX;

using var luna = new LunaUXClient();

byte[] bc = File.ReadAllBytes("script.luac"); // raw bytecode

string src = luna.Decompile(bc, new Dictionary<string, bool> {
    ["useConst"] = true,
});
Console.WriteLine(src);

string dis = luna.Disassemble(bc);
string cfg = luna.CFG(bc); // json
```

## notes

- reuse one `LunaUXClient` (it holds an `HttpClient`). point it elsewhere with
  `new LunaUXClient("https://your-host")` or pass your own `HttpClient`.
- server errors throw `LunaUXException` with the server's `detail` + the status
  code (e.g. `429` when rate limited, `400` bad bytecode).
- server scripts have no bytecode, nothing to decompile.
- same options as the [luau api](../Luau#options) — full list + docs on the
  [docs page](https://lunaux-decompiler.dev/documentation).

## local version

[`LocalAPI.cs`](./LocalAPI.cs) embeds the engine **in your process**, offline, no
key. it loads the python dll at runtime (`NativeLibrary`) and calls the cpython
c api through function pointers, like the [c++ one](../C++). set
`<AllowUnsafeBlocks>true</AllowUnsafeBlocks>` in your csproj. next to the app at runtime:

- `luna.pyd` / `luna.so` (the engine) + `pylib/` (python's `Lib/` + `DLLs/`
  + `Lib/site-packages/tzdata`) + `python313.dll` / `libpython3.13.so`. same set
  the [c++ local api](../C++) and the cli ship.
- the engine module has to be loaded under the name `luna` (its init function is
  `PyInit_luna`), any other name fails with `does not define module export function`.

```csharp
using LunaUX.Local;

using var luna = new LunaUXClient("python313.dll", "./pylib", "./module.pyd"); // libpython3.13.so / luna.so on linux
string src = luna.Decompile(bc, new Dictionary<string, bool> { ["useConst"] = true });
string dis = luna.Disassemble(bc);
string cfg = luna.CFG(bc); // json
```

calls are serialized with a lock + the gil, errors throw `LunaUXLocalException`.

## links

- web: [lunaux-decompiler.dev](https://lunaux-decompiler.dev)
- docs: [lunaux-decompiler.dev/documentation](https://lunaux-decompiler.dev/documentation)
- discord: [discord.gg/2mJUD4XDDT](https://discord.gg/2mJUD4XDDT)
