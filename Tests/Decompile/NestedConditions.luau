return function(p0, p1) --[[ Line: 1 | Named "scan" ]]
	local v0 = nil
	while true do
		task.wait()
		if not p0 or not p0:IsDescendantOf(p1) then break end
		local Position = p0.Position
		
		if Position.Y > 0.8 then
			v0 = Position
		else
			p0.Anchored = false
		end
	end
	return v0
end