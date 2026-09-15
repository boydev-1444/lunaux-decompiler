return function(p0, _) --[[ Line: 1 | Named "poll" ]]
	local Result = nil
	local Positions = nil
	repeat
		task.wait(1)
		Result = workspace:FindFirstChild("Result")
		Positions = Result and Result:FindFirstChild("Positions")
	until Positions and Positions:FindFirstChildOfClass("CFrameValue") or not p0 or not p0.Active
	return Result, Positions
end