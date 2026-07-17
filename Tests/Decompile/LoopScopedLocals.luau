
return function(p0, p1) --[[ line: 1 | named "accumulate" ]]
	local v0 = 0
	repeat
		if not p0 then
			break
		end
		v0 = v0 + p1.Heartbeat:Wait()
	until v0 > 10
	repeat
		v0 = v0 + math.random()
	until v0 > 20
	for i = 1, 5 do
		v0 = v0 + i * 2
	end
	return v0
end