
# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 2 (0x0000002)
# Total functions: 3 (0x0000002)

# Constants [4] (0x0000004)
	[0x0000000] : goto factorial on line 1       : type 6 [0x0000006]
	[0x0000001] : goto fibonacci on line 1       : type 6 [0x0000006]
	[0x0000002] : "print"                        : type 3 [0x0000003]
	[0x0000003] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 17
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function factorial(var0) --[[ Line: 1, Id: 0 ]]
	# Constants [1] (0x0000001)
		[0x0000000] : 1                              : type 2 [0x0000002]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000004]	    LOADN                          A=1   D=1                ; var1 = 1
	[00001] [00001] [0x000001F]	    JUMPIFNOTLE [0x0000001]        A=0   D=3                ; if var0 > var1 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 3 -> 4
	[00000] [00003] [0x0000004]	    LOADN                          A=1   D=1                ; var1 = 1
	[00001] [00004] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

	# BLOCK 2 (B2) | PC 5 -> 10
	[00000] [00005] [0x0000009]	    GETUPVAL                       A=2   B=0                ; var2 = up_0
	[00001] [00006] [0x0000028]	    SUBK                           A=3   B=0   C=0          ; var3 = var0 - 1
	[00002] [00007] [0x0000057]	    CALLFB [0x0000000]             A=2   B=2   C=2          ; var2 = var2(var3)
	[00003] [00009] [0x0000023]	    MUL                            A=1   B=0   C=2          ; var1 = var0 * var2
	[00004] [00010] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = factorial
[00002] [00002] [0x0000046]	    CAPTURE                        A=0   B=0                ; up_0 = var0 -- Readable
local function fibonacci(var0) --[[ Line: 1, Id: 1 ]]
	# Constants [2] (0x0000002)
		[0x0000000] : 1                              : type 2 [0x0000002]
		[0x0000001] : 2                              : type 2 [0x0000002]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000004]	    LOADN                          A=1   D=1                ; var1 = 1
	[00001] [00001] [0x000001F]	    JUMPIFNOTLE [0x0000001]        A=0   D=2                ; if var0 > var1 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 3 -> 3
	[00000] [00003] [0x0000016]	    RETURN                         A=0   B=2                ; return var0

	# BLOCK 2 (B2) | PC 4 -> 13
	[00000] [00004] [0x0000009]	    GETUPVAL                       A=2   B=0                ; var2 = up_0
	[00001] [00005] [0x0000028]	    SUBK                           A=3   B=0   C=0          ; var3 = var0 - 1
	[00002] [00006] [0x0000057]	    CALLFB [0x0000000]             A=2   B=2   C=2          ; var2 = var2(var3)
	[00003] [00008] [0x0000009]	    GETUPVAL                       A=3   B=0                ; var3 = up_0
	[00004] [00009] [0x0000028]	    SUBK                           A=4   B=0   C=1          ; var4 = var0 - 2
	[00005] [00010] [0x0000057]	    CALLFB [0x0000001]             A=3   B=2   C=2          ; var3 = var3(var4)
	[00006] [00012] [0x0000021]	    ADD                            A=1   B=2   C=3          ; var1 = var2 + var3
	[00007] [00013] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

end
[00003] [00003] [0x0000040]	    DUPCLOSURE                     A=1   D=1                ; var1 = fibonacci
[00004] [00004] [0x0000046]	    CAPTURE                        A=0   B=1                ; up_0 = var1 -- Readable
[00005] [00005] [0x000000C]	    GETIMPORT [0x40200000]         A=2   D=3                ; var2 = print
[00006] [00007] [0x0000006]	    MOVE                           A=3   B=0                ; var3 = var0
[00007] [00008] [0x0000004]	    LOADN                          A=4   D=6                ; var4 = 6
[00008] [00009] [0x0000015]	    CALL                           A=3   B=2   C=0          ; ... = var3(var4)
[00009] [00010] [0x0000015]	    CALL                           A=2   B=0   C=1          ; var2(...)
[00010] [00011] [0x000000C]	    GETIMPORT [0x40200000]         A=2   D=3                ; var2 = print
[00011] [00013] [0x0000006]	    MOVE                           A=3   B=1                ; var3 = var1
[00012] [00014] [0x0000004]	    LOADN                          A=4   D=8                ; var4 = 8
[00013] [00015] [0x0000015]	    CALL                           A=3   B=2   C=0          ; ... = var3(var4)
[00014] [00016] [0x0000015]	    CALL                           A=2   B=0   C=1          ; var2(...)
[00015] [00017] [0x0000016]	    RETURN                         A=0   B=1                ; return
