-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 0.8ms ]]

local ClonerefResult = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
print((function(p0, p1) --[[ Line: 1 | Named "resolve" ]]
	return p0 and p0.speed or 16, p0 and p0.name or "unnamed", p0 ~= nil and p0.enabled ~= false or p1
end)({ speed = 32 }, false))
print(ClonerefResult)