local function factorial(v1) --[[ Line: 1 ]]
	-- upvalues: factorial (read)
	if v1 <= 1 then
		return 1;
	end;
	return v1 * factorial(v1 - 1);
end;
local function fibonacci(v2) --[[ Line: 1 ]]
	-- upvalues: fibonacci (read)
	if v2 <= 1 then
		return v2;
	end;
	return fibonacci(v2 - 1) + fibonacci(v2 - 2);
end;
print(factorial(6));
print(fibonacci(8));