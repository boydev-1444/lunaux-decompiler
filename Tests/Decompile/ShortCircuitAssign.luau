
local httpService = cloneref and cloneref(game:GetService("HttpService")) or game:GetService("HttpService")
print((function(p0, p1) --[[ line: 1 | named "resolve" ]]
	return if p0 and p0.speed then p0.speed else 16, if p0 and p0.name then p0.name else "unnamed", p0 ~= nil and p0.enabled ~= false or p1
end)({ speed = 32 }, false))
print(httpService)