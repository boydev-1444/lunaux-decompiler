
local function damage(p0) --[[ line: 14 ]]
	if p0 and p0.Health <= 0 and not p0.Dead then
		p0.Dead = os.clock()
	end
	return p0
end

print((function(p1, p2) --[[ line: 1 | named "cached" ]]
	if not p1 then
		return nil
	end
	if p2[p1] and os.clock() < p2[p1] then
		return p2[p1]
	end
	p2[p1] = os.clock() + 1
	
	return p2[p1]
end)({}, {}))
print(damage({ Health = 0 }))