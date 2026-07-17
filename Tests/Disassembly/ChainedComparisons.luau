
# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 3 (0x0000003)
# Total functions: 4 (0x0000003)

# Constants [5] (0x0000005)
	[0x0000000] : goto inRange on line 1         : type 6 [0x0000006]
	[0x0000001] : goto clamp on line 1           : type 6 [0x0000006]
	[0x0000002] : goto sign on line 1            : type 6 [0x0000006]
	[0x0000003] : "print"                        : type 3 [0x0000003]
	[0x0000004] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 34
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function inRange(var0, var1, var2) --[[ Line: 1, Id: 0 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000003]	    LOADB                          A=3   B=0   C=0          ; var3 = false
	[00001] [00001] [0x000001F]	    JUMPIFNOTLE [0x0000000]        A=1   D=5                ; if var1 > var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 3 -> 3
	[00000] [00003] [0x000001C]	    JUMPIFLE [0x0000002]           A=0   D=2                ; if var0 <= var2 then goto [B4] else goto [B3]

	# BLOCK 3 (B3) | PC 5 -> 5
	[00000] [00005] [0x0000003]	    LOADB                          A=3   B=0   C=1          ; var3 = false ; goto [B2]

	# BLOCK 4 (B4) | PC 6 -> 6
	[00000] [00006] [0x0000003]	    LOADB                          A=3   B=1   C=0          ; var3 = true

	# BLOCK 2 (B2) | PC 7 -> 7
	[00000] [00007] [0x0000016]	    RETURN                         A=3   B=2                ; return var3

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = inRange
local function clamp(var0, var1, var2) --[[ Line: 1, Id: 1 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x0000020]	    JUMPIFNOTLT [0x0000001]        A=0   D=2                ; if var0 >= var1 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 2 -> 2
	[00000] [00002] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

	# BLOCK 2 (B2) | PC 3 -> 3
	[00000] [00003] [0x0000020]	    JUMPIFNOTLT [0x0000000]        A=2   D=2                ; if var2 >= var0 then goto [B3] else goto [B4]

	# BLOCK 3 (B3) | PC 5 -> 5
	[00000] [00005] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

	# BLOCK 4 (B4) | PC 6 -> 6
	[00000] [00006] [0x0000016]	    RETURN                         A=0   B=2                ; return var0

end
[00002] [00002] [0x0000040]	    DUPCLOSURE                     A=1   D=1                ; var1 = clamp
local function sign(var0) --[[ Line: 1, Id: 2 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000004]	    LOADN                          A=2   D=0                ; var2 = 0
	[00001] [00001] [0x0000020]	    JUMPIFNOTLT [0x0000000]        A=2   D=3                ; if var2 >= var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 3 -> 4
	[00000] [00003] [0x0000004]	    LOADN                          A=1   D=1                ; var1 = 1
	[00001] [00004] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

	# BLOCK 2 (B2) | PC 5 -> 6
	[00000] [00005] [0x0000004]	    LOADN                          A=2   D=0                ; var2 = 0
	[00001] [00006] [0x0000020]	    JUMPIFNOTLT [0x0000002]        A=0   D=3                ; if var0 >= var2 then goto [B3] else goto [B4]

	# BLOCK 3 (B3) | PC 8 -> 9
	[00000] [00008] [0x0000004]	    LOADN                          A=1   D=-1               ; var1 = -1
	[00001] [00009] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

	# BLOCK 4 (B4) | PC 10 -> 11
	[00000] [00010] [0x0000004]	    LOADN                          A=1   D=0                ; var1 = 0
	[00001] [00011] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

end
[00003] [00003] [0x0000040]	    DUPCLOSURE                     A=2   D=2                ; var2 = sign
[00004] [00004] [0x000000C]	    GETIMPORT [0x40300000]         A=3   D=4                ; var3 = print
[00005] [00006] [0x0000006]	    MOVE                           A=4   B=0                ; var4 = var0
[00006] [00007] [0x0000004]	    LOADN                          A=5   D=5                ; var5 = 5
[00007] [00008] [0x0000004]	    LOADN                          A=6   D=1                ; var6 = 1
[00008] [00009] [0x0000004]	    LOADN                          A=7   D=10               ; var7 = 10
[00009] [00010] [0x0000015]	    CALL                           A=4   B=4   C=0          ; ... = var4(var5, var6, var7)
[00010] [00011] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00011] [00012] [0x000000C]	    GETIMPORT [0x40300000]         A=3   D=4                ; var3 = print
[00012] [00014] [0x0000006]	    MOVE                           A=4   B=0                ; var4 = var0
[00013] [00015] [0x0000004]	    LOADN                          A=5   D=15               ; var5 = 15
[00014] [00016] [0x0000004]	    LOADN                          A=6   D=1                ; var6 = 1
[00015] [00017] [0x0000004]	    LOADN                          A=7   D=10               ; var7 = 10
[00016] [00018] [0x0000015]	    CALL                           A=4   B=4   C=0          ; ... = var4(var5, var6, var7)
[00017] [00019] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00018] [00020] [0x000000C]	    GETIMPORT [0x40300000]         A=3   D=4                ; var3 = print
[00019] [00022] [0x0000006]	    MOVE                           A=4   B=1                ; var4 = var1
[00020] [00023] [0x0000004]	    LOADN                          A=5   D=15               ; var5 = 15
[00021] [00024] [0x0000004]	    LOADN                          A=6   D=0                ; var6 = 0
[00022] [00025] [0x0000004]	    LOADN                          A=7   D=10               ; var7 = 10
[00023] [00026] [0x0000015]	    CALL                           A=4   B=4   C=0          ; ... = var4(var5, var6, var7)
[00024] [00027] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00025] [00028] [0x000000C]	    GETIMPORT [0x40300000]         A=3   D=4                ; var3 = print
[00026] [00030] [0x0000006]	    MOVE                           A=4   B=2                ; var4 = var2
[00027] [00031] [0x0000004]	    LOADN                          A=5   D=-7               ; var5 = -7
[00028] [00032] [0x0000015]	    CALL                           A=4   B=2   C=0          ; ... = var4(var5)
[00029] [00033] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00030] [00034] [0x0000016]	    RETURN                         A=0   B=1                ; return
