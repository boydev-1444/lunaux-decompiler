-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 0.6ms ]]

local function pick(p1, p2, p3) --[[ Line: 5 ]]
	return if p3 then p1 else p2
end

local function clampScale(p4: number): number --[[ Line: 10 ]]
	local v2 = 47 - p4
	
	return if v2 > 0 then 0.6 + v2 / 40 else 0.6
end

print((function(p0: number): string --[[ Line: 1 | Named "grade" ]]
	return if p0 >= 90 then "A" elseif p0 >= 80 then "B" elseif p0 >= 70 then "C" else "F"
end)(85))
print(pick(1, 2, true))
print(clampScale(20))