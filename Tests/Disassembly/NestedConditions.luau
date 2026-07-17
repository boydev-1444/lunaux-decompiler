
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 1 (0x0000001)
# Total functions: 2 (0x0000001)

# Constants [1] (0x0000001)
	[0x0000000] : goto scan on line 1            : type 6 [0x0000006]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 2
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function scan(var0, var1) --[[ Line: 1, Id: 0 ]]
	# Constants [8] (0x0000008)
		[0x0000000] : "task"                         : type 3 [0x0000003]
		[0x0000001] : "wait"                         : type 3 [0x0000003]
		[0x0000002] : task.wait                      : type 4 [0x0000004]
		[0x0000003] : "IsDescendantOf"               : type 3 [0x0000003]
		[0x0000004] : "Position"                     : type 3 [0x0000003]
		[0x0000005] : "Y"                            : type 3 [0x0000003]
		[0x0000006] : 0.8                            : type 2 [0x0000002]
		[0x0000007] : "Anchored"                     : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x0000002]	    LOADNIL                        A=2                      ; var2 = nil

	# BLOCK 7 (B7) | PC 1 -> 4
	[00000] [00001] [0x000000C]	    GETIMPORT [0x80000400]         A=3   D=2                ; var3 = task.wait
	[00001] [00003] [0x0000015]	    CALL                           A=3   B=1   C=1          ; var3()
	[00002] [00004] [0x000001A]	    JUMPIFNOT                      A=0   D=18               ; if not var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 5 -> 9
	[00000] [00005] [0x0000006]	    MOVE                           A=5   B=1                ; var5 = var1
	[00001] [00006] [0x0000014]	    NAMECALL [0x0000003]           A=3   B=0   C=173        ; <self>var4 = var3 -> var0.IsDescendantOf -- Next CALL/FB instruction must be a __namecall invoker
	[00002] [00008] [0x0000015]	    CALL                           A=3   B=3   C=2          ; var3 = var3(var4, var5)
	[00003] [00009] [0x000001A]	    JUMPIFNOT                      A=3   D=13               ; if not var3 then goto [B3] else goto [B2]

	# BLOCK 3 (B3) | PC 10 -> 15
	[00000] [00010] [0x000000F]	    GETTABLEKS [0x0000004]         A=3   B=0   C=59         ; var3 = var0.Position
	[00001] [00012] [0x000000F]	    GETTABLEKS [0x0000005]         A=4   B=3   C=120        ; var4 = var3.Y
	[00002] [00014] [0x0000005]	    LOADK                          A=5   D=6                ; var5 = 0.8
	[00003] [00015] [0x0000020]	    JUMPIFNOTLT [0x0000004]        A=5   D=3                ; if var5 >= var4 then goto [B4] else goto [B5]

	# BLOCK 4 (B4) | PC 17 -> 18
	[00000] [00017] [0x0000006]	    MOVE                           A=2   B=3                ; var2 = var3
	[00001] [00018] [0x0000017]	    JUMP                           D=3                      ; goto [B6]

	# BLOCK 5 (B5) | PC 19 -> 20
	[00000] [00019] [0x0000003]	    LOADB                          A=4   B=0   C=0          ; var4 = false
	[00001] [00020] [0x0000010]	    SETTABLEKS [0x0000007]         A=4   B=0   C=69         ; var0.Anchored = var4

	# BLOCK 6 (B6) | PC 22 -> 22
	[00000] [00022] [0x0000018]	    JUMPBACK                       D=-22                    ; goto [B7] (possibly repeat loop); continue trough [B2]

	# BLOCK 2 (B2) | PC 23 -> 23
	[00000] [00023] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = scan
[00002] [00002] [0x0000016]	    RETURN                         A=0   B=2                ; return var0
