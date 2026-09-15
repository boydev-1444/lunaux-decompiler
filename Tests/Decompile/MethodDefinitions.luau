local MethodDefinitionsModule = {
	setup = function(p0, p1) --[[ Line: 3 ]]
		p0.ready = p1 ~= nil
		p0.config = p1
	end,
	run = function(p2, p3) --[[ Line: 8 ]]
		return p2.ready and p2:transform(p3)
	end,
	transform = function(_, p5: number): number --[[ Line: 12 ]]
		return p5 * 2
	end,
	static = function(p6, p7) --[[ Line: 16 ]]
		return p6 + p7
	end
}
MethodDefinitionsModule:setup({ speed = 16 })
print(MethodDefinitionsModule:run(5))
print(MethodDefinitionsModule.static(1, 2))

return MethodDefinitionsModule