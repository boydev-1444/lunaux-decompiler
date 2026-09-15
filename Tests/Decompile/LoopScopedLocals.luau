return function(p0, p1): number --[[ Line: 1 | Named "accumulate" ]]
	local v0 = 0
	while p0 do
		v0 += p1.Heartbeat:Wait()
		
		if v0 > 10 then break end
	end
	repeat
		v0 += math.random()
	until v0 > 20
	for i = 1, 5 do
		v0 += i * 2
	end
	return v0
end