<p align="center">
  <img src="./assets/banner.jpg" alt="LunaUX-Decompiler & Disassembler banner">
</p>
<h1 align="center">LunaUX-Decompiler & Disassembler</h1>

- > Luau decompiler & disassembler wrotten in Python V3.13.2 by boydev1444 & zyx
- Join to our [Discord Server](https://discord.gg/2mJUD4XDDT) to get noticed about updates & support, and more!
- API Script [here](https://github.com/boydev-1444/lunaux-decompiler/init.luau)
## Authors
- zyx
  - Main idea
  - Contributor
- [boydev1444](https://github.com/boydev-1444)
  - Bring this

- Inspirated on Konstant and medal's decompilers, this decompiler was created to bring free perfect decompilation service as medal or konstant (v3)
- Many thanks also to **plusgiant5** for answering my questions. Without him, We wouldn't be here.

### Loadstring
```lua
local SETTINGS = {
	URL = "https://raw.githubusercontent.com/boydev-1444/lunaux-decompiler/main/",
	PRINT_FUNCTIONS = false,
	FILE = "init"
}
assert(SETTINGS.URL and SETTINGS.FILE , "Not initializable")
-- TODO: Automatically adds the decompile & disassemble functions to the env.
local TABLE_WITH_FUNCTIONS = loadstring(game:HttpGet(SETTINGS.URL .. SETTINGS.FILE .. ".luau"))()
if SETTINGS.PRINT_FUNCTIONS then 
	warn(string.rep("=" , 10) .. "LunaUX-Decompiler Functions" .. string.rep("=" , 10))
	for name , object in next , TABLE_WITH_FUNCTIONS do
		local t = type(object)
		warn(`{name} : {if t == "function" then "Function" elseif t == "table" then "Library" else "Unsupported"}`)
	end
	warn(string.rep("=" , 47))
end
```

### Core Functions
```lua
local env = (getgenv or getfenv or getrenv)()
env.decompile(<string or Instance>:(input , options : table[...])>): string
env.disassemble(<string or Instance>:(input)>): string
```