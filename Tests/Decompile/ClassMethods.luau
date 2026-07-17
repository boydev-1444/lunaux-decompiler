
local t = {}
t.__index = t

function t.new(p0, p1) --[[ line: 4 ]]
	-- upvalues: t (ref)
	local t_1 = setmetatable({}, t)
	t_1.name = p0
	t_1.health = p1
	
	return t_1
end

function t:takeDamage(p2) --[[ line: 11 ]]
	self.health = self.health - p2
	
	if self.health <= 0 then
		self:die()
	end
end

function t:die() --[[ line: 18 ]]
	self.dead = true
end

function t:isAlive() --[[ line: 22 ]]
	return not self.dead and 0 < self.health
end

local t_1 = {
	clamp = function(value, minValue, maxValue) --[[ line: 27 ]]
		return math.max(minValue, math.min(maxValue, value))
	end
}
local goblin = t.new("goblin", 10)
goblin:takeDamage(5)
print(goblin:isAlive())
print(t_1.clamp(5, 0, 3))

return t