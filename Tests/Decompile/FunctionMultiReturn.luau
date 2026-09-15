local v0, v1 = (function(p0: number, p1: number, p2: number) --[[ Line: 1 | Named "minmax" ]]
	return math.min(p0, p1, p2), (math.max(p0, p1, p2))
end)(7, 2, 5)
print(v0, v1)