-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 1.1ms ]]

local Module = {
	setup = function(p0, Config) --[[ Line: 3 ]]
		p0.ready = Config ~= nil
		p0.config = Config
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
Module:setup({ speed = 16 })
print(Module:run(5))
print(Module.static(1, 2))

return Module