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