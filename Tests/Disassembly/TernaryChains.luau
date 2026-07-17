
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 3 (0x0000003)
# Total functions: 4 (0x0000003)

# Constants [5] (0x0000005)
	[0x0000000] : goto grade on line 1           : type 6 [0x0000006]
	[0x0000001] : goto pick on line 5            : type 6 [0x0000006]
	[0x0000002] : goto clampScale on line 10     : type 6 [0x0000006]
	[0x0000003] : "print"                        : type 3 [0x0000003]
	[0x0000004] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 24
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function grade(var0) --[[ Line: 1, Id: 0 ]]
	# Constants [4] (0x0000004)
		[0x0000000] : "A"                            : type 3 [0x0000003]
		[0x0000001] : "B"                            : type 3 [0x0000003]
		[0x0000002] : "C"                            : type 3 [0x0000003]
		[0x0000003] : "F"                            : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000004]	    LOADN                          A=2   D=90               ; var2 = 90
	[00001] [00001] [0x000001F]	    JUMPIFNOTLE [0x0000000]        A=2   D=3                ; if var2 > var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 3 -> 4
	[00000] [00003] [0x0000005]	    LOADK                          A=1   D=0                ; var1 = "A"
	[00001] [00004] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

	# BLOCK 2 (B2) | PC 5 -> 6
	[00000] [00005] [0x0000004]	    LOADN                          A=2   D=80               ; var2 = 80
	[00001] [00006] [0x000001F]	    JUMPIFNOTLE [0x0000000]        A=2   D=3                ; if var2 > var0 then goto [B3] else goto [B4]

	# BLOCK 3 (B3) | PC 8 -> 9
	[00000] [00008] [0x0000005]	    LOADK                          A=1   D=1                ; var1 = "B"
	[00001] [00009] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

	# BLOCK 4 (B4) | PC 10 -> 11
	[00000] [00010] [0x0000004]	    LOADN                          A=2   D=70               ; var2 = 70
	[00001] [00011] [0x000001F]	    JUMPIFNOTLE [0x0000000]        A=2   D=3                ; if var2 > var0 then goto [B5] else goto [B6]

	# BLOCK 5 (B5) | PC 13 -> 14
	[00000] [00013] [0x0000005]	    LOADK                          A=1   D=2                ; var1 = "C"
	[00001] [00014] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

	# BLOCK 6 (B6) | PC 15 -> 16
	[00000] [00015] [0x0000005]	    LOADK                          A=1   D=3                ; var1 = "F"
	[00001] [00016] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = grade
local function pick(var0, var1, var2) --[[ Line: 5, Id: 1 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x000001A]	    JUMPIFNOT                      A=2   D=2                ; if not var2 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 1 -> 2
	[00000] [00001] [0x0000006]	    MOVE                           A=3   B=0                ; var3 = var0
	[00001] [00002] [0x0000016]	    RETURN                         A=3   B=2                ; return var3

	# BLOCK 2 (B2) | PC 3 -> 4
	[00000] [00003] [0x0000006]	    MOVE                           A=3   B=1                ; var3 = var1
	[00001] [00004] [0x0000016]	    RETURN                         A=3   B=2                ; return var3

end
[00002] [00002] [0x0000040]	    DUPCLOSURE                     A=1   D=1                ; var1 = pick
local function clampScale(var0) --[[ Line: 10, Id: 2 ]]
	# Constants [3] (0x0000003)
		[0x0000000] : 47                             : type 2 [0x0000002]
		[0x0000001] : 0.6                            : type 2 [0x0000002]
		[0x0000002] : 40                             : type 2 [0x0000002]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 2
	[00000] [00000] [0x0000047]	    SUBRK                          A=1   B=0   C=0          ; var1 = 47 - var0
	[00001] [00001] [0x0000004]	    LOADN                          A=3   D=0                ; var3 = 0
	[00002] [00002] [0x0000020]	    JUMPIFNOTLT [0x0000001]        A=3   D=5                ; if var3 >= var1 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 4 -> 7
	[00000] [00004] [0x0000005]	    LOADK                          A=3   D=1                ; var3 = 0.6
	[00001] [00005] [0x000002A]	    DIVK                           A=4   B=1   C=2          ; var4 = var1 / 40
	[00002] [00006] [0x0000021]	    ADD                            A=2   B=3   C=4          ; var2 = var3 + var4
	[00003] [00007] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

	# BLOCK 2 (B2) | PC 8 -> 9
	[00000] [00008] [0x0000005]	    LOADK                          A=2   D=1                ; var2 = 0.6
	[00001] [00009] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00003] [00003] [0x0000040]	    DUPCLOSURE                     A=2   D=2                ; var2 = clampScale
[00004] [00004] [0x000000C]	    GETIMPORT [0x40300000]         A=3   D=4                ; var3 = print
[00005] [00006] [0x0000006]	    MOVE                           A=4   B=0                ; var4 = var0
[00006] [00007] [0x0000004]	    LOADN                          A=5   D=85               ; var5 = 85
[00007] [00008] [0x0000015]	    CALL                           A=4   B=2   C=0          ; ... = var4(var5)
[00008] [00009] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00009] [00010] [0x000000C]	    GETIMPORT [0x40300000]         A=3   D=4                ; var3 = print
[00010] [00012] [0x0000006]	    MOVE                           A=4   B=1                ; var4 = var1
[00011] [00013] [0x0000004]	    LOADN                          A=5   D=1                ; var5 = 1
[00012] [00014] [0x0000004]	    LOADN                          A=6   D=2                ; var6 = 2
[00013] [00015] [0x0000003]	    LOADB                          A=7   B=1   C=0          ; var7 = true
[00014] [00016] [0x0000015]	    CALL                           A=4   B=4   C=0          ; ... = var4(var5, var6, var7)
[00015] [00017] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00016] [00018] [0x000000C]	    GETIMPORT [0x40300000]         A=3   D=4                ; var3 = print
[00017] [00020] [0x0000006]	    MOVE                           A=4   B=2                ; var4 = var2
[00018] [00021] [0x0000004]	    LOADN                          A=5   D=20               ; var5 = 20
[00019] [00022] [0x0000015]	    CALL                           A=4   B=2   C=0          ; ... = var4(var5)
[00020] [00023] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00021] [00024] [0x0000016]	    RETURN                         A=0   B=1                ; return
