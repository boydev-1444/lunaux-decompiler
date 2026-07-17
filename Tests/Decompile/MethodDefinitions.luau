
local t = {
	setup = function(value, p0) --[[ line: 3 ]]
		value.ready = p0 ~= nil
		value.config = p0
	end,
	run = function(p1, p2) --[[ line: 8 ]]
		return p1.ready and p1:transform(p2)
	end,
	transform = function(_, p3) --[[ line: 12 ]]
		return p3 * 2
	end,
	static = function(p4, p5) --[[ line: 16 ]]
		return p4 + p5
	end
}
t:setup({ speed = 16 })
print(t:run(5))
print(t.static(1, 2))

return t