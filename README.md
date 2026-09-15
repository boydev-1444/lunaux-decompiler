# LunaUX-Decompiler [![Version](https://img.shields.io/badge/Version-V_1.4.3-8A2BE2.svg)](https://lunaux-decompiler.dev/download) [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<p align="center"> <img src="./Assets/Banner.png" width=1000 > </p>

## > Discord server [here](https://discord.gg/2mJUD4XDDT)

- A decompiler & disassembler for [Luau](https://luau.org) (Roblox's Lua-based language). This project consists of an algorithm that takes raw Luau bytecode and attempts to reconstruct it into readable Luau source code or low level disassembly.

- Inspirated on Konstant, Oracle and medal, this decompiler was created to bring free decompilation service as medal or other decompilers.

> **Disclaimer:** LunaUX is still in beta, it is not 100% perfect. This decompiler will receive regular updates to fix all those bugs.

# Using it

There's no local server to install anymore &mdash; the engine runs at **[lunaux-decompiler.dev](https://lunaux-decompiler.dev)** and everything talks to it directly:

- **[Web demo](https://lunaux-decompiler.dev/demo)** &mdash; drop a `.luauc`/`.bin` file (or paste base64 bytecode) and decompile, disassemble or view the CFG right in the browser.
- **[Downloads](https://lunaux-decompiler.dev/download)** &mdash; the native desktop CLI, the raw engine library (Windows `.pyd` / Linux `.so`) and a bundled runtime, for people who want it offline or scripted into their own tools.
- **[Documentation](https://lunaux-decompiler.dev/documentation)** &mdash; the full API reference and every decompile option.
- This repo's [`Tests/`](./Tests) folder is the same fixed set of Luau bytecode samples used to sanity-check every engine release &mdash; each one's `Binary/`, `Decompile/` and `Disassembly/` output side by side, generated straight from `lunaux-src`'s own binary test corpus.

# API Script

- Paste it into an environment that supports `request`, `base64encode`/`crypt` and `getscriptbytecode`. No API key needed for `decompile`/`disassemble`.

```lua
assert(request, "http request function missing")
assert(getscriptbytecode, "getscriptbytecode function missing")
local base64_encoder = (crypt and crypt.base64 and crypt.base64.encode) or base64encode
assert(base64_encoder, "base64encode function missing")
local http = game:GetService("HttpService")

local API_BASE = "https://lunaux-decompiler.dev"

local function apiRequest(bytecode, endpoint, scriptName)
    local response = request({
        Url = API_BASE .. "/api/" .. endpoint,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = http:JSONEncode({ bytecode = base64_encoder(bytecode), filename = scriptName })
    })
    if response.StatusCode ~= 200 then
        return `--[[ Server error (HTTP {response.StatusCode}):\n\t{response.Body}\n]]`
    end
    return response.Body
end

local function isValidScript(scriptInstance: BaseScript)
    return (scriptInstance.ClassName == "Script" and scriptInstance.RunContext == Enum.RunContext.Client)
        or scriptInstance.ClassName == "LocalScript"
        or scriptInstance.ClassName == "ModuleScript"
end

if getgenv then
    getgenv().decompile = function(scriptPath: BaseScript)
        if typeof(scriptPath) ~= "Instance" then return "-- Invalid argument #1 to 'decompile' (Instance expected)" end
        if not isValidScript(scriptPath) then return "-- Server scripts are IMPOSSIBLE to decompile" end
        local OK, bytecode = pcall(getscriptbytecode, scriptPath)
        if not OK then return `--[[ Failed to get script bytecode:\n\t{bytecode}\n]]` end
        if type(bytecode) ~= "string" then return `--[[ Failed to get script bytecode, string type expected got {type(bytecode)} ]]` end
        if bytecode == "" then return "-- Empty bytecode" end
        return apiRequest(bytecode, "decompile", scriptPath.Name)
    end

    getgenv().disassemble = function(scriptPath: BaseScript)
        if typeof(scriptPath) ~= "Instance" then return "-- Invalid argument #1 to 'disassemble' (Instance expected)" end
        if not isValidScript(scriptPath) then return "-- Server scripts are IMPOSSIBLE to disassemble" end
        local OK, bytecode = pcall(getscriptbytecode, scriptPath)
        if not OK then return `--[[ Failed to get script bytecode:\n\t{bytecode}\n]]` end
        if type(bytecode) ~= "string" then return `--[[ Failed to get script bytecode, string type expected got {type(bytecode)} ]]` end
        if bytecode == "" then return "-- Empty bytecode" end
        return apiRequest(bytecode, "disassemble", scriptPath.Name)
    end
end
```

- A ready-to-run copy of this script also lives at [`script.luau`](./script.luau) in this repo.

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

# Tests

[`Tests/`](./Tests) mirrors `lunaux-src`'s `BinaryTests/` corpus &mdash; the same 22 Luau bytecode samples used for every release's regression and speed benchmarks:

- `Tests/Binary/*.luauc` &mdash; the raw compiled bytecode.
- `Tests/Decompile/*.luau` &mdash; that bytecode decompiled with the current engine, default options.
- `Tests/Disassembly/*.luau` &mdash; the same bytecode disassembled.
