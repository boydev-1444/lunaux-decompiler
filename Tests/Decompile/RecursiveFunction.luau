
local function factorial(p0) --[[ line: 1 ]]
	-- upvalues: factorial (ref)
	return if p0 <= 1 then 1 else p0 * factorial(p0 - 1)
end

local function fibonacci(p1) --[[ line: 1 ]]
	-- upvalues: fibonacci (ref)
	return if p1 <= 1 then p1 else fibonacci(p1 - 1) + fibonacci(p1 - 2)
end

print(factorial(6))
print(fibonacci(8))