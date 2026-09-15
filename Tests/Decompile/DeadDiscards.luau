local RunService = game:GetService("RunService")
local _ = RunService:IsClient()
local _ = RunService:IsServer()
local v3 = RunService:IsStudio()

if RunService:IsServer() then
	local _ = require(game:GetService("ServerScriptService"))
end
print(v3)