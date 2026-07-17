
local runService = game:GetService("RunService")
local _ = runService:IsClient()
local _ = runService:IsServer()
local v1 = runService:IsStudio()

if runService:IsServer() then
	local _ = require(game:GetService("ServerScriptService"))
end
print(v1)