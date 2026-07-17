
return function(p0, p1) --[[ line: 1 | named "scan" ]]
	local v0 = nil
	while true do
		task.wait()
		if not (p0 and p0:IsDescendantOf(p1)) then
			break
		end
		local position = p0.Position
		
		if position.Y > 0.8 then
			v0 = position
		else
			p0.Anchored = false
		end
		return v0
	end
end