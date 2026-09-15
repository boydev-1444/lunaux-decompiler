local function damage(p2) --[[ Line: 14 ]]
	if p2 and p2.Health <= 0 and not p2.Dead then
		p2.Dead = os.clock()
	end
	return p2
end

print((function(p0, p1) --[[ Line: 1 | Named "cached" ]]
	if not p0 then
		return nil
	elseif p1[p0] and os.clock() < p1[p0] then
		return p1[p0]
	else
		p1[p0] = os.clock() + 1
		
		return p1[p0]
	end
end)({}, {}))
print(damage({ Health = 0 }))