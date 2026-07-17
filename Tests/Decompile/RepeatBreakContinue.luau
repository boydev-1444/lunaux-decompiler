
return function(p0, _) --[[ line: 1 | named "poll" ]]
	local result, positions
	local _ = nil
	local _ = nil
	repeat
		task.wait(1)
		result = workspace:FindFirstChild("Result")
		positions = result and result:FindFirstChild("Positions")
	until positions and positions:FindFirstChildOfClass("CFrameValue") or not (p0 and p0.Active)
	return result, positions
end