
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 1 (0x0000001)
# Total functions: 2 (0x0000001)

# Constants [1] (0x0000001)
	[0x0000000] : goto poll on line 1            : type 6 [0x0000006]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 2
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function poll(var0, var1) --[[ Line: 1, Id: 0 ]]
	# Constants [11] (0x000000B)
		[0x0000000] : "task"                         : type 3 [0x0000003]
		[0x0000001] : "wait"                         : type 3 [0x0000003]
		[0x0000002] : task.wait                      : type 4 [0x0000004]
		[0x0000003] : "workspace"                    : type 3 [0x0000003]
		[0x0000004] : workspace                      : type 4 [0x0000004]
		[0x0000005] : "Result"                       : type 3 [0x0000003]
		[0x0000006] : "FindFirstChild"               : type 3 [0x0000003]
		[0x0000007] : "Positions"                    : type 3 [0x0000003]
		[0x0000008] : "CFrameValue"                  : type 3 [0x0000003]
		[0x0000009] : "FindFirstChildOfClass"        : type 3 [0x0000003]
		[0x000000A] : "Active"                       : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000002]	    LOADNIL                        A=2                      ; var2 = nil
	[00001] [00001] [0x0000002]	    LOADNIL                        A=3                      ; var3 = nil

	# BLOCK 8 (B8) | PC 2 -> 14
	[00000] [00002] [0x000000C]	    GETIMPORT [0x80000400]         A=4   D=2                ; var4 = task.wait
	[00001] [00004] [0x0000004]	    LOADN                          A=5   D=1                ; var5 = 1
	[00002] [00005] [0x0000015]	    CALL                           A=4   B=2   C=1          ; var4(var5)
	[00003] [00006] [0x000000C]	    GETIMPORT [0x40300000]         A=4   D=4                ; var4 = workspace
	[00004] [00008] [0x0000005]	    LOADK                          A=6   D=5                ; var6 = "Result"
	[00005] [00009] [0x0000014]	    NAMECALL [0x0000006]           A=4   B=4   C=3          ; <self>var5 = var4 -> var4.FindFirstChild -- Next CALL/FB instruction must be a __namecall invoker
	[00006] [00011] [0x0000015]	    CALL                           A=4   B=3   C=2          ; var4 = var4(var5, var6)
	[00007] [00012] [0x0000006]	    MOVE                           A=2   B=4                ; var2 = var4
	[00008] [00013] [0x0000006]	    MOVE                           A=4   B=2                ; var4 = var2
	[00009] [00014] [0x000001A]	    JUMPIFNOT                      A=4   D=4                ; if not var4 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 15 -> 18
	[00000] [00015] [0x0000005]	    LOADK                          A=6   D=7                ; var6 = "Positions"
	[00001] [00016] [0x0000014]	    NAMECALL [0x0000006]           A=4   B=2   C=3          ; <self>var5 = var4 -> var2.FindFirstChild -- Next CALL/FB instruction must be a __namecall invoker
	[00002] [00018] [0x0000015]	    CALL                           A=4   B=3   C=2          ; var4 = var4(var5, var6)

	# BLOCK 2 (B2) | PC 19 -> 20
	[00000] [00019] [0x0000006]	    MOVE                           A=3   B=4                ; var3 = var4
	[00001] [00020] [0x000001A]	    JUMPIFNOT                      A=3   D=5                ; if not var3 then goto [B3] else goto [B4]

	# BLOCK 3 (B3) | PC 21 -> 25
	[00000] [00021] [0x0000005]	    LOADK                          A=6   D=8                ; var6 = "CFrameValue"
	[00001] [00022] [0x0000014]	    NAMECALL [0x0000009]           A=4   B=3   C=184        ; <self>var5 = var4 -> var3.FindFirstChildOfClass -- Next CALL/FB instruction must be a __namecall invoker
	[00002] [00024] [0x0000015]	    CALL                           A=4   B=3   C=2          ; var4 = var4(var5, var6)
	[00003] [00025] [0x0000019]	    JUMPIF                         A=4   D=5                ; if var4 then goto [B5] else goto [B4]

	# BLOCK 4 (B4) | PC 26 -> 26
	[00000] [00026] [0x000001A]	    JUMPIFNOT                      A=0   D=4                ; if not var0 then goto [B6] else goto [B5]

	# BLOCK 6 (B6) | PC 27 -> 29
	[00000] [00027] [0x000000F]	    GETTABLEKS [0x000000A]         A=4   B=0   C=131        ; var4 = var0.Active
	[00001] [00029] [0x000001A]	    JUMPIFNOT                      A=4   D=1                ; if not var4 then goto [B7] else goto [B5]

	# BLOCK 7 (B7) | PC 30 -> 30
	[00000] [00030] [0x0000018]	    JUMPBACK                       D=-29                    ; goto [B8] (possibly repeat loop); continue trough [B5]

	# BLOCK 5 (B5) | PC 31 -> 31
	[00000] [00031] [0x0000016]	    RETURN                         A=2   B=3                ; return var2, var3

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = poll
[00002] [00002] [0x0000016]	    RETURN                         A=0   B=2                ; return var0
