# LunaUX-Decompiler [![Version](https://img.shields.io/badge/Version-Beta_1.3-8A2BE2.svg)](https://github.com/boydev-1444/lunaux-decompiler/releases/tag/lastest) [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<p align="center"> <img src="https://cdn.discordapp.com/attachments/1365953466622804020/1505053498553663698/Banner.png?ex=6a0939cc&is=6a07e84c&hm=fc7b30959a664c64f0a82c162678b5b8029de9c9ee1f3239cbc34cd328c624e5&" width=1000 > </p>

## > Discord server [here](https://discord.gg/2mJUD4XDDT)

- A decompiler & disassembler for [Luau](https://luau.org) (Roblox's Lua-based language). This project consists of an algorithm that takes raw Luau bytecode and attempts to reconstruct it into readable Luau source code or low level disassembly.

- Inspirated on Konstant, Oracle and medal, this decompiler was created to bring free decompilation service as medal or other decompilers.


> **Disclaimer:** LunaUX is still in beta, it is not 100% perfect. This decompiler will receive regular updates to fix all those bugs. 

# Installing

<p align="center"> <img src="./Assets/Console.gif" width="800" /> </p>

- ## Windows

```shell
git clone https://github.com/boydev-1444/lunaux-decompiler.git
cd lunaux-decompiler
run.bat
```

- ### Linux

```bash
git clone https://github.com/boydev-1444/lunaux-decompiler.git 
cd lunaux-decompiler 
chmod +x run.sh 
./run.sh
```

# API Script

- Paste it into an environment than supports `request`, `base64encode` or `crypt` library and `getscriptbytecode`

```lua
assert(request, "http request function missing")
assert(getscriptbytecode, "getscriptbytecode function missing")
local base64_encoder = (crypt and crypt.base64 and crypt.base64.encode) or base64encode
assert(base64_encoder, "base64encode function missing")
local http = game:GetService("HttpService")

local function apiRequest(bytecode, branch, scriptName)
    local response = request({
        Url = 'http://127.0.0.1:8000/' .. branch,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = http:JSONEncode({ bytecode = base64_encoder(bytecode), filename = scriptName })
    })
    if response.StatusCode ~= 200 then
        return `--[[ Server error (HTTP {response.StatusCode}:\n\t{response.Body}\n]]`
    end
    return response.Body
end

local function isValidScript(scriptInstance : BaseScript)
    return (scriptInstance.ClassName == "Script" and scriptInstance.RunContext == Enum.RunContext.Client) or scriptInstance.ClassName == "LocalScript" or scriptInstance.ClassName == "ModuleScript"
end

if getgenv then 
  getgenv().decompile = function(scriptPath : BaseScript)
      if typeof(scriptPath) ~= "Instance" return "-- Invalid argument #1 to 'decompile' (Instance expected)" end
      if not isValidScript(scriptPath) return "-- Server scripts are IMPOSSIBLE to decompile"
      local OK, bytecode = pcall(getscriptbytecode, scriptPath)
      if not OK then return `--[[ Failed to get script bytecode:\n\t{bytecode}\n]]` end
      if type(bytecode) ~= "string" then return `--[[ Failed to get script bytecode, string type expected got {type(bytecode)} ]]` end
      if bytecode == "" then return "-- Empty bytecode" end
      return apiRequest(bytecode, "decompile", scriptPath.Name)
  end

  getgenv().disassemble = function(scriptPath : BaseScript)
      if typeof(scriptPath) ~= "Instance" return "-- Invalid argument #1 to 'disassemble' (Instance expected)" end
      if not isValidScript(scriptPath) return "-- Server scripts are IMPOSSIBLE to disassemble"
      local OK, bytecode = pcall(getscriptbytecode, scriptPath)
      if not OK then return `--[[ Failed to get script bytecode:\n\t{bytecode}\n]]` end
      if type(bytecode) ~= "string" then return `--[[ Failed to get script bytecode, string type expected got {type(bytecode)} ]]` end
      if bytecode == "" then return "-- Empty bytecode" end
      return apiRequest(bytecode, "disassemble", scriptPath.Name) 
  end
end
```

# API Options

- All decompiling options:
  - `Semicolons` : Add a semicolon for every line (Default: False)
  - `StringInterpolation` : Enables string interpolation between strings (Default: True)
  - `UpvalueComment` :  Every upvalue used in a function (Default: True)
  - `ShowLineDefined` : Adds the original line defined of the prototype (Default: True)
  - `ShowFunctionId` : Adds the original function id in the bytecode (`ShowlineDefined` must be enabled; Default : False)
  - `PreserveForStep` : Keeps the step for the numeric loop including if is one (Default: False)
  - `UseIfExpression` : Uses `if ... then ... else ...` in assigns, if not enabled uses AND/OR operators (Default: True)


# CLI Application

- Tool for fast analysis or other
  - Supports base64 encoded inputs or raw bytecodes

```shell
Options:
  -h, --help       Show this help message
  -v, --version    Show version information
  -ih, --hash      Show the current installer hash

Commands:
  run
    Start the LunaUX-Decompiler local server.

  * These commands support raw bytecode or Base64-encoded bytecode

  decomp, decompile <input_file> [output_directory]
      Decompile the specified bytecode file.
      If an output directory is provided, the result will be saved there;
      otherwise, it will be printed to the console.

  disasm, disassemble <input_file> [output_directory]
      Disassemble the specified bytecode file.
      If an output directory is provided, the result will be saved there;
      otherwise, it will be printed to the console.
```

# Compiling CLI by yourself

- The CLI application is already compiled and you can find it in the releases tab.

- ### Windows
```shell
g++ CliApp.cpp -o CLI.exe -std=c++20 -O2 -s -lws2_32
```

- ### Linux
```bash
x86_64-w64-mingw32-g++ CliApp.cpp -o CLI.exe -std=c++20 -O2 -s -lws2_32
```
