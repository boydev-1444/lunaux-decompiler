# LunaUX-Decompiler [![Version](https://img.shields.io/badge/Version-V_1.4.7-8A2BE2.svg)](https://lunaux-decompiler.dev/download) [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<p align="center"> <img src="./Assets/Banner.png" width=1000 > </p>

## > Discord server [here](https://discord.gg/2mJUD4XDDT)

- A decompiler & disassembler for [Luau](https://luau.org) (Roblox's Lua-based language). This project consists of an algorithm that takes raw Luau bytecode and attempts to reconstruct it into readable Luau source code or low level disassembly.

- Inspirated on Konstant, Oracle and medal, this decompiler was created to bring free decompilation service as medal or other decompilers.

> **Disclaimer:** LunaUX is not 100% perfect. This decompiler will receive regular updates to fix all those bugs.

# Using it

LunaUX runs online at **[lunaux-decompiler.dev](https://lunaux-decompiler.dev)**, and you can also run it offline on your own machine:

- **[Web demo](https://lunaux-decompiler.dev/demo)** &mdash; drop a `.luauc`/`.bin` file (or paste base64 bytecode) and decompile, disassemble or view the CFG right in the browser.
- **[Downloads](https://lunaux-decompiler.dev/download)** &mdash; the native desktop CLI, the raw engine library (Windows `.pyd` / Linux `.so`) and a bundled runtime, for people who want it offline or scripted into their own tools.
- **[Documentation](https://lunaux-decompiler.dev/documentation)** &mdash; the full API reference and every decompile option.

# API Script

- Paste it into an environment that supports `request`, `base64encode`/`crypt` and `getscriptbytecode`. No API key needed for `decompile`/`disassemble`.

```lua
loadstring(game:HttpGet("https://lunaux-decompiler.dev/script"))()
```

- Clients for Luau, C++, C#, Python and Rust are in [`Scripts/`](./Scripts).

# API Options

Passed as the `options` field on `/api/decompile`. Full descriptions and before/after examples are on the [documentation page](https://lunaux-decompiler.dev/documentation).

| Option | Default | Description |
|---|---|---|
| `transformCompoundAssignments` | `true` | Collapses `x = x + 1` into `x += 1`. |
| `virtualizeContinues` | `true` | Reconstructs `continue` for loop-back jumps instead of inverting the guard. |
| `showFunctionInfo` | `true` | Trailing comment with the function's source line and original closure name. |
| `upvalueComments` | `true` | Comment listing each closure's captured upvalues and how they're captured. |
| `forNumericSugaring` | `false` | Keeps the numeric `for` loop's step explicit even when it's the default `1`. |
| `genericForSugaring` | `false` | Keeps `next, tbl, nil`'s trailing `nil` explicit instead of sugaring it away. |
| `collapseGuardClasuses` | `true` | Writes single-statement guard clauses (`if not x then return end`) on one line. |
| `expandWhileCondition` | `false` | Keeps a loop's guard as a `break` in the body instead of folding it into `while cond do`. |
| `inlineEmptyFunctions` | `true` | Closes an empty function body on the same line as its header. |
| `emitUtf` | `true` | Renders high-bit string bytes as raw UTF-8 instead of octal escapes. |
| `useConst` | `false` | Emits Luau's `const` for locals/functions proven never reassigned. |
| `stringInterpolation` | `true` | Rewrites simple `("%s"):format(x)` calls into backtick string interpolation. |
| `typeAnnotations` | `true` | Annotates parameters/returns with inferred Luau types where confident. |
| `inlineTroughBlock` | `false` | Allows expression inlining to cross basic block boundaries. |
