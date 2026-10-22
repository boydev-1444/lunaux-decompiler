-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 0.4ms ]]

local RunService = game:GetService("RunService")
local _ = RunService:IsClient()
local _ = RunService:IsServer()
local IsStudio = RunService:IsStudio()

if RunService:IsServer() then
	local _ = require(game:GetService("ServerScriptService"))
end
print(IsStudio)