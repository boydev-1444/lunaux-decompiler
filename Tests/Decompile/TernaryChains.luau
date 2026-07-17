
local function grade(p0) --[[ line: 1 ]]
	return if p0 >= 90 then "A" elseif p0 >= 80 then "B" elseif p0 >= 70 then "C" else "F"
end

local function pick(p1, p2, p3) --[[ line: 5 ]]
	return if p3 then p1 else p2
end

local function clampScale(value) --[[ line: 10 ]]
	local v3 = 47 - value
	
	return if v3 > 0 then 0.6 + v3 / 40 else 0.6
end

print(grade(85))
print(pick(1, 2, true))
print(clampScale(20))