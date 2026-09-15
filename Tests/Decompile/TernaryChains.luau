local function pick(p1, p2, p3) --[[ Line: 5 ]]
	if p3 then
		return p1
	else
		return p2
	end
end

local function clampScale(p4: number): number --[[ Line: 10 ]]
	local v2 = 47 - p4
	
	if v2 > 0 then
		return 0.6 + v2 / 40
	else
		return 0.6
	end
end

print((function(p0: number): string --[[ Line: 1 | Named "grade" ]]
	if p0 >= 90 then
		return "A"
	elseif p0 >= 80 then
		return "B"
	elseif p0 >= 70 then
		return "C"
	else
		return "F"
	end
end)(85))
print(pick(1, 2, true))
print(clampScale(20))