type RenamingType = "SMART" | "MEDIUM" | "LOW"
type RequestParameters = { Url : string , Method : string? , Headers : {}? , Body : string? }
type Response = { StatusCode : number , Body : string , Success : boolean}
type GlobalContainer = { request : (Parameters : RequestParameters) -> Response, base64encode : (Input : string) -> string, getscriptbytecode : (...any) -> string}
type DecompilerOptions = { 
	RenamingType : RenamingType,
	ShowLineDefined : boolean?,
	RenameFunctionIfIsUpvalue : boolean?,
	UpvalueComment : boolean?,
	SemicolonAfterLine : boolean?,
	UpvaluePrefix : string?,
	VariablePrefix : string?,
}

local API_URL = "https://lunaux-decompiler.railway.com"
local Options : DecompilerOptions = {}
--TODO: NO-EXPLOIT SETTINGS
-- This is an example, if you're executing this script in the server, don't edit it (IT ALWAYS NEEDS TO BE A REMOTE FUNCTION OR BINDABLE FUNCTION)
-- If there is the RemoteFunction in the path you must add a server listener to the RemoteFunction
-- Add this script in ServerScriptService than listens to the RemoteFunction and returns the decompiled script
--[[
	-- SERVER LISTENER (MUST NEED TO BE A SERVER SCRIPT)
	assert(script:IsA("Script") and (script.RunContext.Name == "Legacy" or script.RunContext == "Server"), "The Server Listener must need to be a server script.")
	script.Name = "ServerListener"
	local TARGET = game.ReplicatedStorage.Http -- MUST NEED TO BE THAN YOU HAVE LINKED BELOW
	local HttpService = game:GetService("HttpService")
	assert(HttpService.HttpEnabled , "Please enable HTTP Requests")
	TARGET[if TARGET:IsA("RemoteFunction") then "OnServerInvoke" else "OnInvoke"] = function(...)
		local Args = {...}
		if typeof(Args[1]) == "Instance" and Args[1]:IsA("Player") then
			table.remove(Args,1) -- Remove the player argument
		end
		return HttpService:RequestAsync(Args)
	end
]]
-- EXAMPLE PATH: "ReplicatedStorage.ConnectHttp"
local HTTP_REMOTE_FUNCTION_PATH = nil -- Leave it as empty or nil
-- Custom HTTP Function, you can use your own and needs to be an function that returns a table with the following keys:
--[[
	-- These are the most important for now.
	StatusCode : number,
	Body : string,
	Success : boolean,
	...
]]
-- As parameters you can use Url, Body, Headers, Method, etc.
local CUSTOM_HTTP_FUNCTION
local CURRENT -- Ignore this

-- Custom compiling function, it will recieve the script instance and should return the bytecode
-- You can use your own compiler as:
-- Luau Ception: https://raw.githubusercontent.com/kosuke14/vLuau/refs/heads/main/Ception.luau
-- Loadstring: 
-- Or other luau compiler
-- NOTE: The compiler will not be used if you're using this on a exploit or if getscriptbytecode is enabled
local CUSTOM_COMPILE_FUNCTION = function(scriptPath : ScriptBase) : string
	return require("../ReplicatedStorage/Ception").luau_compile(scriptPath.Source)
end
-- Example (USING LuauCeption):
--[[
	local CUSTOM_COMPILE_FUNCTION = function(scriptPath : ScriptBase) : string
		return require("Ception").luau_compile(scriptPath.Source)
	end
]]

-- Initialize for exploits i guess..?
local now = os.clock()
local env = getgenv or getrenv
local global_container : GlobalContainer
local string_find, string_lower, string_byte, string_sub, string_gsub, string_format, string_rep = string.find, string.lower, string.byte, string.sub, string.gsub, string.format, string.rep
local math_floor, math_huge = math.floor, math.huge
local table_insert, table_concat = table.insert, table.concat
local type, typeof, tostring, select, next, pairs, rawget, pcall, error, assert = type, typeof, tostring, select, next, pairs, rawget, pcall, error, assert

if env then
	env = env()
	local finder
	assert(type(game.HttpGet) == "function") -- Should be true
	finder , global_container = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SomeHub/main/UniversalMethodFinder.luau"))()
	-- Find all possibles (why i """"obfuscated"""" it)
	finder({
		base64encode = 'local a={...}local b=a[1]local function c(a,b)return string.find(a,b,nil,true)end;return c(b,"encode")and(c(b,"base64")or c(string.lower(tostring(a[2])),"base64"))',
		getscriptbytecode = 'string.find(...,"get",nil,true) and string.find(...,"bytecode",nil,true) or string.find(...,"dump",nil,true) and string.find(...,"string",nil,true)',
		request = 'string.find(...,"request",nil,true) and not string.find(...,"internal",nil,true)'
	})
else
	global_container = global_container or {}
	if not global_container.base64encode then
		local base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		local base64Lookup = {}
		for i = 1, 64 do
			base64Lookup[i-1] = string_sub(base64Chars, i, i)
		end

		global_container.base64encode = function(input : string) : string
			local output = {}
			local inputLen = #input
			local remainder = inputLen % 3
			local paddingLen = remainder > 0 and (3 - remainder) or 0
			local processLen = inputLen + paddingLen

			if paddingLen > 0 then
				input = input .. string_rep("\0", paddingLen)
			end

			local idx = 1
			for i = 1, processLen, 3 do
				local b1, b2, b3 = string_byte(input, i, i + 2)
				local combined = b1 * 65536 + b2 * 256 + b3
				output[idx] = base64Lookup[math_floor(combined / 262144)]
				output[idx+1] = base64Lookup[math_floor(combined / 4096) % 64]
				output[idx+2] = base64Lookup[math_floor(combined / 64) % 64]
				output[idx+3] = base64Lookup[combined % 64]
				idx = idx + 4
			end

			if paddingLen > 0 then
				local outLen = #output
				for i = 1, paddingLen do
					output[outLen - paddingLen + i] = "="
				end
			end

			return table_concat(output)
		end
	end

	if not global_container.request then
		local Function 
		if CUSTOM_HTTP_FUNCTION then
			Function = CUSTOM_HTTP_FUNCTION
		else
			local RunService = game:GetService("RunService")
			if (not RunService:IsClient()) or RunService:IsStudio() then
				-- Means than this is a server
				local HttpService = game:GetService("HttpService")
				assert(HttpService.HttpEnabled , "FATAL: HTTP requets is not enabled")
				Function = function(...)
					return HttpService:RequestAsync(...)
				end
			else
				if HTTP_REMOTE_FUNCTION_PATH and HTTP_REMOTE_FUNCTION_PATH ~= "" then
					local obj = game
					local pathParts = {}
					for part in string.gmatch(HTTP_REMOTE_FUNCTION_PATH, "[^.]+") do
						pathParts[#pathParts + 1] = part
					end
					for i = 1, #pathParts do
						obj = obj:FindFirstChild(pathParts[i])
						assert(obj , string_format("Instance `%s` was nil at position %d", pathParts[i] , i))
					end
					assert(typeof(obj) == "Instance" and (obj:IsA("RemoteFunction") or obj:IsA("BindableFunction")) , "Target must need to be a <Remote/Bindable>Function for returning the final data.")
					local Method = obj:IsA("RemoteFunction") and "InvokeServer" or "Invoke"
					Function = function(...)
						return obj[Method](obj , ...)
					end	
				end
			end
		end
		assert(Function and type(Function) == "function" , string_format("Type `%s` was not passed for the main function", type(Function)))
		global_container.request = function(params)
			local Output = Function(params)
			return Output or {
				StatusCode = 504,
				Body = "The server did not responded.",
				Success = false
			}
		end
	end
end

local escape_char_map = {
	["\\"] = "\\", ['"'] = '"', ["\b"] = "b", ["\f"] = "f", ["\n"] = "n", ["\r"] = "r", ["\t"] = "t"
}
local escape_pattern = '[%z\1-\31\\"]'

local function escape_char(c)
	return "\\" .. (escape_char_map[c] or string_format("u%04x", string_byte(c)))
end

local function encode_nil() return "null" end

local function encode_string(val)
	return '"' .. string_gsub(val, escape_pattern, escape_char) .. '"'
end

local function encode_number(val)
	if val ~= val or val <= -math_huge or val >= math_huge then
		error("unexpected number value '" .. tostring(val) .. "'")
	end
	return string_format("%.14g", val)
end

local function encode_table(val, stack)
	stack = stack or {}
	if stack[val] then error("circular reference") end
	stack[val] = true

	local isArray = rawget(val, 1) ~= nil or next(val) == nil

	if isArray then
		local n = 0
		for k in pairs(val) do
			if type(k) ~= "number" then
				error("invalid table: mixed or invalid key types")
			end
			n = n + 1
		end
		if n ~= #val then
			error("invalid table: sparse array")
		end

		local res = {}
		for i = 1, n do
			res[i] = jsonize(val[i], stack)
		end
		stack[val] = nil
		return "[" .. table_concat(res, ",") .. "]"
	else
		local res = {}
		local idx = 1
		for k, v in pairs(val) do
			if type(k) ~= "string" then
				error("invalid table: mixed or invalid key types")
			end
			res[idx] = encode_string(k) .. ":" .. jsonize(v, stack)
			idx = idx + 1
		end
		stack[val] = nil
		return "{" .. table_concat(res, ",") .. "}"
	end
end

local type_func_map = {
	["nil"] = encode_nil,
	["table"] = encode_table,
	["string"] = encode_string,
	["number"] = encode_number,
	["boolean"] = tostring,
}

jsonize = function(val, stack)
	local f = type_func_map[type(val)]
	if f then return f(val, stack) end
	error("unexpected type '" .. type(val) .. "'")
end

-- TODO: Verifying before using
assert(global_container and global_container.request and global_container.base64encode , "Missing methods")
CURRENT = global_container.request({ Url = "https://example.com" }) -- Checking if the request is working
assert(CURRENT.StatusCode == 200 , string_format("Server responded with Status code: `%s`", CURRENT.StatusCode))
assert(jsonize({}) == "[]" , "JSON is broken.")
CURRENT = global_container.base64encode("Hello World!") -- Checking if the base64 encoder is working
assert(CURRENT == "SGVsbG8gV29ybGQh" , string_format("Base64 encoder is not working, expected `SGVsbG8gV29ybGQh` got `%s`", CURRENT))
local getBytecode = global_container.getscriptbytecode or CUSTOM_COMPILE_FUNCTION
assert(getBytecode , "Compiler is not available.")

local RunContext_Client = Enum.RunContext.Client
local function isScriptValid(script)
	local class = script.ClassName
	return (class == "Script" and script.RunContext == RunContext_Client) or class == "LocalScript" or class == "ModuleScript"
end

local API_decompile = API_URL .. "/api/decompile"
local API_disassemble = API_URL .. "/api/disassemble"

local function endpointFunction(endpoint, scriptPath, options)
	local target_bytecode = scriptPath
	if type(target_bytecode) == "userdata" and typeof and typeof(target_bytecode) == "Instance" then
		if not isScriptValid(scriptPath) then
			return "-- Invalid script to decompile, expected Client or ModuleScript, but got Script with RC as Serverside instead."
		end
		local OK , bytecode = pcall(getBytecode , scriptPath)
		if not OK then
			return "--[[ Failed to grab bytecode, error:\n\t" .. tostring(bytecode) .. "\n]]"
		end
		target_bytecode = bytecode
	end
	if type(target_bytecode) ~= "string" then
		return "--[[ Failed to grab bytecode, expected a string got " .. type(target_bytecode) .. " ]]"
	end

	local request = global_container.request({
		Url = endpoint,
		Method = "POST",
		Body = jsonize({
			bytecode = global_container.base64encode(target_bytecode),
			filename = scriptPath.Name,
			options = options or Options
		}),
		Headers = {
			Authorization = "what are you looking at?",
			["Content-Type"] = "application/json"
		}
	})

	if request.StatusCode ~= 200 then
		return "--[[ Server error: " .. request.StatusCode .. "\n\n\t" .. request.Body .. "\n]]"
	end
	if not request.Success then
		return "--[[ Failed to grab bytecode, server responded with (HTTP " .. request.StatusCode .. "):\n\t" .. request.Body .. "\n]]"
	end
	return request.Body
end

local function checkArgs(n)
	assert(n > 0 and n <= 2 , "Invalid argument count expected in 1-2 range, got " .. n)
end

-- Takes the bytecode and converts it into Luau readable code
-- Reconstructs the original high-level source code from compiled bytecode
-- Returns human-friendly Lua/Luau syntax with:
-- - Variable names (may be generic like var0, var1)
-- - Control structures (if, while, for loops)
-- - Function definitions and calls
-- - Readable logic flow as it would appear in a .lua file
local function decompile(...)
	checkArgs(select("#" , ...))
	return endpointFunction(API_decompile , ...)
end

-- Takes the bytecode and converts it into assembly-like instructions
-- Returns a human-readable representation of the bytecode showing:
-- - Individual opcodes and their operations (LOADN, RETURN, etc.)
-- - Memory slots, parameters, and upvalues used
-- - Constants and function references
-- - Low-level execution flow without reconstructing high-level syntax
local function disassemble(...)
	checkArgs(select("#" , ...))
	return endpointFunction(API_disassemble , ...)
end

if env then
	env.decompile = decompile
	env.disassemble = disassemble
	return
end

return {
	decompile = decompile,
	disassemble = disassemble,
}
