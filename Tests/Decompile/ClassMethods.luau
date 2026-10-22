-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 0.9ms ]]

local Module = {}
Module.__index = Module

function Module.new(Name, Health) --[[ Line: 4 ]]
	-- upvalues: Module (copy)
	local self = setmetatable({}, Module)
	self.name = Name
	self.health = Health
	
	return self
end

function Module:takeDamage(p3) --[[ Line: 11 ]]
	self.health -= p3
	
	if self.health <= 0 then
		self:die()
	end
end

function Module:die() --[[ Line: 18 ]]
	self.dead = true
end

function Module:isAlive(): boolean --[[ Line: 22 ]]
	return not self.dead and self.health > 0
end

local config = {
	clamp = function(p6: number, p7: number, p8: number): number --[[ Line: 27 ]]
		return math.max(p7, math.min(p8, p6))
	end
}
local Goblin = Module.new("goblin", 10)
Goblin:takeDamage(5)
print(Goblin:isAlive())
print(config.clamp(5, 0, 3))

return Module