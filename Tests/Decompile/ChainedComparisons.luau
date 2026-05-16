-- [[ Decompiled using LunaUX-Decompiler V1.3. Luau decompiler made by boydev1444 & zyx (https://discord.gg/2mJUD4XDDT) ]]
-- [[ Decompiled on Fri May 15 20:44:41 2026 (UTC -6), took 0.001471 second(s) ]]

local function inRange(v1, v2, v3) --[[ Line: 1 ]]
	local v4 = false;
	if v2 <= v1 then
		v4 = v1 <= v3;
	end;
	return v4;
end;
local function clamp(v2, v3, v4) --[[ Line: 1 ]]
	if v2 < v3 then
		return v3;
	end;
	if v4 < v2 then
		return v4;
	end;
	return v2;
end;
local function sign(v3) --[[ Line: 1 ]]
	if v3 > 0 then
		return 1;
	end;
	if v3 < 0 then
		return -1;
	end;
	return 0;
end;
print(inRange(5, 1, 10));
print(inRange(15, 1, 10));
print(clamp(15, 0, 10));
print(sign(-7));