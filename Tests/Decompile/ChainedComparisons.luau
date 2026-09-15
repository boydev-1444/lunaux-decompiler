local function inRange(p0, p1, p2): boolean --[[ Line: 1 ]]
	return p1 <= p0 and p0 <= p2
end

local function clamp(p3, p4, p5) --[[ Line: 1 ]]
	if p3 < p4 then
		return p4
	elseif p5 < p3 then
		return p5
	else
		return p3
	end
end

local function sign(p6: number): number --[[ Line: 1 ]]
	if p6 > 0 then
		return 1
	elseif p6 < 0 then
		return -1
	else
		return 0
	end
end

print(inRange(5, 1, 10))
print(inRange(15, 1, 10))
print(clamp(15, 0, 10))
print(sign(-7))