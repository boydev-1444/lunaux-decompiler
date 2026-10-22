-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 0.6ms ]]

return function(p0, p1): number --[[ Line: 1 | Named "accumulate" ]]
	local Total = 0
	while p0 do
		Total += p1.Heartbeat:Wait()
		
		if Total > 10 then break end
	end
	repeat
		Total += math.random()
	until Total > 20
	for i = 1, 5 do
		Total += i * 2
	end
	return Total
end