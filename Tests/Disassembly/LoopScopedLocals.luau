
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 1 (0x0000001)
# Total functions: 2 (0x0000001)

# Constants [1] (0x0000001)
	[0x0000000] : goto accumulate on line 1      : type 6 [0x0000006]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 2
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function accumulate(var0, var1) --[[ Line: 1, Id: 0 ]]
	# Constants [6] (0x0000006)
		[0x0000000] : "Heartbeat"                    : type 3 [0x0000003]
		[0x0000001] : "Wait"                         : type 3 [0x0000003]
		[0x0000002] : "math"                         : type 3 [0x0000003]
		[0x0000003] : "random"                       : type 3 [0x0000003]
		[0x0000004] : math.random                    : type 4 [0x0000004]
		[0x0000005] : 2                              : type 2 [0x0000002]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x0000004]	    LOADN                          A=2   D=0                ; var2 = 0

	# BLOCK 4 (B4) | PC 1 -> 1
	[00000] [00001] [0x000001A]	    JUMPIFNOT                      A=0   D=10               ; if not var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 2 -> 9
	[00000] [00002] [0x000000F]	    GETTABLEKS [0x0000000]         A=3   B=1   C=253        ; var3 = var1.Heartbeat
	[00001] [00004] [0x0000014]	    NAMECALL [0x0000001]           A=3   B=3   C=247        ; <self>var4 = var3 -> var3.Wait -- Next CALL/FB instruction must be a __namecall invoker
	[00002] [00006] [0x0000015]	    CALL                           A=3   B=2   C=2          ; var3 = var3(var4)
	[00003] [00007] [0x0000021]	    ADD                            A=2   B=2   C=3          ; var2 = var2 + var3
	[00004] [00008] [0x0000004]	    LOADN                          A=4   D=10               ; var4 = 10
	[00005] [00009] [0x000001D]	    JUMPIFLT [0x0000002]           A=4   D=2                ; if var4 < var2 then goto [B2] else goto [B3]

	# BLOCK 3 (B3) | PC 11 -> 11
	[00000] [00011] [0x0000018]	    JUMPBACK                       D=-11                    ; goto [B4] (possibly repeat loop); continue trough [B2]

	# BLOCK 2 (B2) | PC 12 -> 17
	[00000] [00012] [0x000000C]	    GETIMPORT [0x80200C00]         A=3   D=4                ; var3 = math.random
	[00001] [00014] [0x0000015]	    CALL                           A=3   B=1   C=2          ; var3 = var3()
	[00002] [00015] [0x0000021]	    ADD                            A=2   B=2   C=3          ; var2 = var2 + var3
	[00003] [00016] [0x0000004]	    LOADN                          A=4   D=20               ; var4 = 20
	[00004] [00017] [0x000001D]	    JUMPIFLT [0x0000002]           A=4   D=2                ; if var4 < var2 then goto [B6] else goto [B5]

	# BLOCK 5 (B5) | PC 19 -> 19
	[00000] [00019] [0x0000018]	    JUMPBACK                       D=-8                     ; goto [B2] (possibly repeat loop); continue trough [B6]

	# BLOCK 6 (B6) | PC 20 -> 23
	[00000] [00020] [0x0000004]	    LOADN                          A=5   D=1                ; var5 = 1
	[00001] [00021] [0x0000004]	    LOADN                          A=3   D=5                ; var3 = 5
	[00002] [00022] [0x0000004]	    LOADN                          A=4   D=1                ; var4 = 1
	[00003] [00023] [0x0000038]	    FORNPREP                       A=3   D=3                ; for var5 = var5, var3, var4 do goto [B7]

	# BLOCK 7 (B7) | PC 24 -> 25
	[00000] [00024] [0x0000029]	    MULK                           A=6   B=5   C=5          ; var6 = var5 * 2
	[00001] [00025] [0x0000021]	    ADD                            A=2   B=2   C=6          ; var2 = var2 + var6

	# BLOCK 9 (B9) | PC 26 -> 26
	[00000] [00026] [0x0000039]	    FORNLOOP                       A=3   D=-3               ; var5 += var4; if var5 <= var3 then goto [B7] else goto [B8]

	# BLOCK 8 (B8) | PC 27 -> 27
	[00000] [00027] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = accumulate
[00002] [00002] [0x0000016]	    RETURN                         A=0   B=2                ; return var0
