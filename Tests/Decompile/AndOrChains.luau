
local function allTrue(p0, p1, p2, p3) --[[ line: 1 ]]
	return p0 and (p1 and (p2 and p3))
end

local function anyTrue(p4, p5, p6) --[[ line: 5 ]]
	return p4 or (p5 or p6)
end

local function mixed(p7, p8, p9) --[[ line: 9 ]]
	return p7 > 0 and p8 < 10 and p9 ~= nil
end

local function fallback(p10, p11, p12) --[[ line: 14 ]]
	return p10 or p11 and (typeof(p11) == "table" and (p11.value or (p12 or "default")))
end

print(allTrue(1, 2, 3, 4))
print(anyTrue(nil, false, 5))
print(mixed(5, 3, {}))
print(fallback(nil, { value = 7 }, nil))