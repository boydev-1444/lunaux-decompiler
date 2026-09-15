local function factorial(p0: number) --[[ Line: 1 ]]
	-- upvalues: factorial (copy)
	if p0 <= 1 then
		return 1
	else
		return p0 * factorial(p0 - 1)
	end
end

local function fibonacci(p1: number) --[[ Line: 1 ]]
	-- upvalues: fibonacci (copy)
	if p1 <= 1 then
		return p1
	else
		return fibonacci(p1 - 1) + fibonacci(p1 - 2)
	end
end

print(factorial(6))
print(fibonacci(8))