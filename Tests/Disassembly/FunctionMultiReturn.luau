# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 1 (0x0000001)
# Total functions: 2 (0x0000001)

# Constants [3] (0x0000003)
	[0x0000000] : goto minmax on line 1          : type 6 [0x0000006]
	[0x0000001] : "print"                        : type 3 [0x0000003]
	[0x0000002] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 12
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function minmax(var0, var1, var2) --[[ Line: 1, Id: 0 ]]
	# Constants [5] (0x0000005)
		[0x0000000] : "math"                         : type 3 [0x0000003]
		[0x0000001] : "min"                          : type 3 [0x0000003]
		[0x0000002] : math.min                       : type 4 [0x0000004]
		[0x0000003] : "max"                          : type 3 [0x0000003]
		[0x0000004] : math.max                       : type 4 [0x0000004]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 16
	[00000] [00000] [0x000003C]	    FASTCALL3 [0x0000201]          A=19  C=6                ; ... = math.min(var0, var1, var2) -- Uses args and results from the CALL instruction located in [00005]. If successful goto >= [00006]
	[00001] [00002] [0x0000006]	    MOVE                           A=4   B=0                ; var4 = var0
	[00002] [00003] [0x0000006]	    MOVE                           A=5   B=1                ; var5 = var1
	[00003] [00004] [0x0000006]	    MOVE                           A=6   B=2                ; var6 = var2
	[00004] [00005] [0x000000C]	    GETIMPORT [0x80000400]         A=3   D=2                ; var3 = math.min
	[00005] [00007] [0x0000015]	    CALL                           A=3   B=4   C=2          ; var3 = var3(var4, var5, var6)
	[00006] [00008] [0x000003C]	    FASTCALL3 [0x0000201]          A=18  C=6                ; ... = math.max(var0, var1, var2) -- Uses args and results from the CALL instruction located in [00013]. If successful goto >= [00014]
	[00007] [00010] [0x0000006]	    MOVE                           A=5   B=0                ; var5 = var0
	[00008] [00011] [0x0000006]	    MOVE                           A=6   B=1                ; var6 = var1
	[00009] [00012] [0x0000006]	    MOVE                           A=7   B=2                ; var7 = var2
	[00010] [00013] [0x000000C]	    GETIMPORT [0x80000C00]         A=4   D=4                ; var4 = math.max
	[00011] [00015] [0x0000015]	    CALL                           A=4   B=4   C=2          ; var4 = var4(var5, var6, var7)
	[00012] [00016] [0x0000016]	    RETURN                         A=3   B=3                ; return var3, var4

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = minmax
[00002] [00002] [0x0000006]	    MOVE                           A=1   B=0                ; var1 = var0
[00003] [00003] [0x0000004]	    LOADN                          A=2   D=7                ; var2 = 7
[00004] [00004] [0x0000004]	    LOADN                          A=3   D=2                ; var3 = 2
[00005] [00005] [0x0000004]	    LOADN                          A=4   D=5                ; var4 = 5
[00006] [00006] [0x0000015]	    CALL                           A=1   B=4   C=3          ; var1, var2 = var1(var2, var3, var4)
[00007] [00007] [0x000000C]	    GETIMPORT [0x40100000]         A=3   D=2                ; var3 = print
[00008] [00009] [0x0000006]	    MOVE                           A=4   B=1                ; var4 = var1
[00009] [00010] [0x0000006]	    MOVE                           A=5   B=2                ; var5 = var2
[00010] [00011] [0x0000015]	    CALL                           A=3   B=3   C=1          ; var3(var4, var5)
[00011] [00012] [0x0000016]	    RETURN                         A=0   B=1                ; return