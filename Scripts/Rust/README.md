# LunaUX Rust API

client for [lunaux-decompiler.dev](https://lunaux-decompiler.dev). same as the
[luau http flavour](../Luau) / the [c# one](../CSharp) but in rust: decompile /
disassemble / cfg over https, no key. sync, returns the string straight like the
[c++ one](../C++).

went http instead of embedding python (pyo3) on purpose — the c++ api already
covers the local/offline route, and a rust client is way lighter.

one struct, [`HttpAPI.rs`](./HttpAPI.rs):

- `decompile(bytecode, options)` -> source
- `disassemble(bytecode)` -> listing
- `cfg(bytecode)` -> json

## requirements

```toml
[dependencies]
ureq = "2"
serde_json = "1"
base64 = "0.22"
```

## usage

```rust
use std::collections::BTreeMap;

let luna = LunaUXClient::new();

let bc = std::fs::read("script.luac").unwrap(); // raw bytecode

let mut opts = BTreeMap::new();
opts.insert("useConst".to_string(), true);

let src = luna.decompile(&bc, Some(&opts)).unwrap();
println!("{src}");

let dis = luna.disassemble(&bc).unwrap();
let cfg = luna.cfg(&bc).unwrap(); // json
```

## notes

- errors come back as `Err(LunaError { status, detail })` — `detail` is the
  server's message (e.g. `429` rate limited, `400` bad bytecode).
- point it elsewhere with `LunaUXClient::with_base("https://your-host")`.
- server scripts have no bytecode, nothing to decompile.
- same options as the [luau api](../Luau#options), docs on the
  [docs page](https://lunaux-decompiler.dev/documentation).

## local version

[`LocalAPI.rs`](./LocalAPI.rs) embeds the engine **in your process**, offline, no
key. it loads the python dll at runtime (`libloading`) and talks to the cpython
c api directly, like the [c++ one](../C++). no pyo3, nothing to link at build time.

needs in `Cargo.toml`: `libloading = "0.8"`. next to the binary at runtime:

- `luna.pyd` / `luna.so` (the engine) + `pylib/` (python's `Lib/` + `DLLs/`
  + `Lib/site-packages/tzdata`) + `python313.dll` / `libpython3.13.so`. same set
  the [c++ local api](../C++) and the cli ship.
- the engine module has to be loaded under the name `luna` (its init function is
  `PyInit_luna`), any other name fails with `does not define module export function`.

```rust
let luna = LunaUXClient::new("python313.dll", "./pylib", "./luna.pyd")?; // libpython3.13.so / luna.so on linux
let src = luna.decompile(&bc, Some(&BTreeMap::from([("useConst".to_string(), true)])))?;
let dis = luna.disassemble(&bc)?;
let cfg = luna.cfg(&bc)?; // json
```

calls are serialized behind a mutex + the gil, errors come back as `LunaError`.

## links

- web: [lunaux-decompiler.dev](https://lunaux-decompiler.dev)
- docs: [lunaux-decompiler.dev/documentation](https://lunaux-decompiler.dev/documentation)
- discord: [discord.gg/2mJUD4XDDT](https://discord.gg/2mJUD4XDDT)
