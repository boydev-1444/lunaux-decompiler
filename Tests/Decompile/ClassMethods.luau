local ClassMethodsModule = {}
ClassMethodsModule.__index = ClassMethodsModule

function ClassMethodsModule.new(p0, p1) --[[ Line: 4 ]]
	-- upvalues: ClassMethodsModule (copy)
	local Object = setmetatable({}, ClassMethodsModule)
	Object.name = p0
	Object.health = p1
	
	return Object
end

function ClassMethodsModule:takeDamage(p3) --[[ Line: 11 ]]
	self.health -= p3
	
	if self.health <= 0 then
		self:die()
	end
end

function ClassMethodsModule:die() --[[ Line: 18 ]]
	self.dead = true
end

function ClassMethodsModule:isAlive(): boolean --[[ Line: 22 ]]
	return not self.dead and self.health > 0
end

local config = {
	clamp = function(p6: number, p7: number, p8: number): number --[[ Line: 27 ]]
		return math.max(p7, math.min(p8, p6))
	end
}
local Goblin = ClassMethodsModule.new("goblin", 10)
Goblin:takeDamage(5)
print(Goblin:isAlive())
print(config.clamp(5, 0, 3))

return ClassMethodsModule