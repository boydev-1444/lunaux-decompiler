
local function inRange(p0, p1, p2) --[[ line: 1 ]]
	return p1 <= p0 and p0 <= p2
end

local function clamp(value, minValue, maxValue) --[[ line: 1 ]]
	return if value < minValue then minValue elseif maxValue < value then maxValue else value
end

local function sign(value) --[[ line: 1 ]]
	return if value > 0 then 1 elseif value < 0 then -1 else 0
end

print(inRange(5, 1, 10))
print(inRange(15, 1, 10))
print(clamp(15, 0, 10))
print(sign(-7))