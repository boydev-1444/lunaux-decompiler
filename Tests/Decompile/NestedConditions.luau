-- [[ lunaux-decompiler.dev | v1.4.7 | discord.gg/2mJUD4XDDT ]]
-- [[ Luau version 9 | Types version 3 | took 0.5ms ]]

return function(Part, Ancestor) --[[ Line: 1 | Named "scan" ]]
	local v0 = nil
	while true do
		task.wait()
		if not Part or not Part:IsDescendantOf(Ancestor) then break end
		local Position = Part.Position
		
		if Position.Y > 0.8 then
			v0 = Position
		else
			Part.Anchored = false
		end
	end
	return v0
end