-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 0.9ms ]]

local function damage(Humanoid) --[[ Line: 14 ]]
	if Humanoid and Humanoid.Health <= 0 and not Humanoid.Dead then
		Humanoid.Dead = os.clock()
	end
	return Humanoid
end

print((function(Key, NewClockTimes) --[[ Line: 1 | Named "cached" ]]
	if not Key then
		return nil
	elseif NewClockTimes[Key] and os.clock() < NewClockTimes[Key] then
		return NewClockTimes[Key]
	else
		NewClockTimes[Key] = os.clock() + 1
		
		return NewClockTimes[Key]
	end
end)({}, {}))
print(damage({ Health = 0 }))