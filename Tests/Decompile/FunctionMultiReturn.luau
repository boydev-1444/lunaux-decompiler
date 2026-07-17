
local v0, v1 = (function(a, b, p0) --[[ line: 1 | named "minmax" ]]
	return math.min(a, b, p0), math.max(a, b, p0)
end)(7, 2, 5)
print(v0, v1)