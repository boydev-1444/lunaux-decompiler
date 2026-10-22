-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 11 | Types version 3 | took 0.5ms ]]

local function inRange(p0, p1, p2): boolean --[[ Line: 1 ]]
	return p1 <= p0 and p0 <= p2
end

local function clamp(p3, p4, p5) --[[ Line: 1 ]]
	return if p3 < p4 then p4 elseif p5 < p3 then p5 else p3
end

local function sign(p6: number): number --[[ Line: 1 ]]
	return if p6 > 0 then 1 elseif p6 < 0 then -1 else 0
end

print(inRange(5, 1, 10))
print(inRange(15, 1, 10))
print(clamp(15, 0, 10))
print(sign(-7))