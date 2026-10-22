# LunaUX Luau API

drop-in `decompile` / `disassemble` globals for roblox executors, backed by
[lunaux-decompiler.dev](https://lunaux-decompiler.dev). two flavours:

| Script | Transport | Key | Loadstring |
|---|---|---|---|
| [`API.luau`](./API.luau) | http (`/api/decompile`, `/api/disassemble`) | no | `loadstring(game:HttpGet("https://lunaux-decompiler.dev/script"))()` |
| [`WebSocket.luau`](./WebSocket.luau) | websocket (`wss://.../connect`) | **yes** | `loadstring(game:HttpGet("https://lunaux-decompiler.dev/socket"))()` |

the `.luau` files here are just those loadstrings. the real scripts are served by
lunaux so you always get the latest. both set `getgenv().decompile` and
`getgenv().disassemble`, so anything running after can just call them.

## requirements

your executor needs:

- `getscriptbytecode`
- `request` (or `http_request`, `syn.request`, `fluxus.request`, `krnl.request`)
- a base64 encoder (`crypt.base64encode`, `base64encode`, ...). if there's none, a built-in fallback kicks in.
- *websocket only:* `sha256` (or `crypt.hash`) + a `WebSocket` lib. if the executor has none, one is pulled from [zyx6b/luau-wss](https://github.com/zyx6b/luau-wss).

> server scripts have no bytecode on the client, so you can't decompile them.

## key (socket only)

`WebSocket.luau` needs a key from [lunaux-decompiler.dev/getkey](https://lunaux-decompiler.dev/getkey)
(they start with `luna_`). set it **before** running:

```lua
getgenv().WEBSOCKET_KEY = "luna_xxxxxxxxxxxxxxxx"
loadstring(game:HttpGet("https://lunaux-decompiler.dev/socket"))()
```

it validates the key, then keeps one socket alive in the background (re-checks
every 30s and reconnects if it drops).

## usage

```lua
loadstring(game:HttpGet("https://lunaux-decompiler.dev/script"))()

local src = decompile(game.Players.LocalPlayer.PlayerScripts.SomeLocalScript)
print(src)

print(disassemble(someModuleScript))
```

**`decompile(source, options?)`** — `source` is a script instance or raw bytecode
string, `options` is an optional `{ [string]: boolean }`. returns the source string.

**`disassemble(source)`** — same source arg, returns the disassembly string.

errors are never thrown — they come back as a comment (`-- LunaUX Error: ...`), so
the result is always safe to print or save.

## options

```lua
decompile(script, {
    useConst = true,
    stringInterpolation = false,
})
```

| Option | Default |
|---|---|
| `showFunctionInfo` | `true` |
| `upvalueComments` | `true` |
| `emitBlockId` | `false` |
| `emitUtf` | `true` |
| `useConst` | `false` |
| `stringInterpolation` | `true` |
| `inlineEmptyFunctions` | `true` |
| `collapseElseifs` | `false` |
| `collapseGuardClauses` | `true` |
| `collapseDiamondReturns` | `true` |
| `expandWhileCondition` | `false` |
| `virtualizeContinues` | `true` |
| `genericForSugaring` | `false` |
| `forNumericSugaring` | `false` |
| `transformCompoundAssignments` | `true` |
| `inlineTroughBlock` | `false` |
| `betterMethodCallAnalysis` | `false` |
| `typeAnnotations` | `true` |

full descriptions + before/after on the [docs](https://lunaux-decompiler.dev/documentation).

## notes

- **cache:** results are cached per bytecode + options, so decompiling the same script twice doesn't hit the server again.
- **retries (http):** network errors, `408`, `425` and `5xx` get retried up to 4 times with backoff, requests spaced 0.5s apart.
- **rate limit (http):** on `429` it returns how long to wait. for heavy use grab the cli from [lunaux-decompiler.dev/download](https://lunaux-decompiler.dev/download).
- **timeout (socket):** no reply in 15s returns a timeout error.
- **telemetry:** `API.luau` sends executor name, `PlaceId` and `GameId` as headers. opt out with `_G.DisableDecompilerTelemetry = true` before running it.

## links

- web: [lunaux-decompiler.dev](https://lunaux-decompiler.dev)
- docs: [lunaux-decompiler.dev/documentation](https://lunaux-decompiler.dev/documentation)
- discord: [discord.gg/2mJUD4XDDT](https://discord.gg/2mJUD4XDDT)
