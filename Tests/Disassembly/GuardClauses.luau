
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 2 (0x0000002)
# Total functions: 3 (0x0000002)

# Constants [7] (0x0000007)
	[0x0000000] : goto cached on line 1          : type 6 [0x0000006]
	[0x0000001] : goto damage on line 14         : type 6 [0x0000006]
	[0x0000002] : "print"                        : type 3 [0x0000003]
	[0x0000003] : print                          : type 4 [0x0000004]
	[0x0000004] : "Health"                       : type 3 [0x0000003]
	[0x0000005] : 0                              : type 2 [0x0000002]
	[0x0000006] : { Health = 0 }                 : type 8 [0x0000008]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 18
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function cached(var0, var1) --[[ Line: 1, Id: 0 ]]
	# Constants [4] (0x0000004)
		[0x0000000] : "os"                           : type 3 [0x0000003]
		[0x0000001] : "clock"                        : type 3 [0x0000003]
		[0x0000002] : os.clock                       : type 4 [0x0000004]
		[0x0000003] : 1                              : type 2 [0x0000002]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x0000019]	    JUMPIF                         A=0   D=2                ; if var0 then goto [B2] else goto [B1]

	# BLOCK 1 (B1) | PC 1 -> 2
	[00000] [00001] [0x0000002]	    LOADNIL                        A=2                      ; var2 = nil
	[00001] [00002] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

	# BLOCK 2 (B2) | PC 3 -> 4
	[00000] [00003] [0x000000D]	    GETTABLE                       A=2   B=1   C=0          ; var2 = var1[var0]
	[00001] [00004] [0x000001A]	    JUMPIFNOT                      A=2   D=8                ; if not var2 then goto [B3] else goto [B4]

	# BLOCK 3 (B3) | PC 5 -> 9
	[00000] [00005] [0x000000D]	    GETTABLE                       A=2   B=1   C=0          ; var2 = var1[var0]
	[00001] [00006] [0x000000C]	    GETIMPORT [0x80000400]         A=3   D=2                ; var3 = os.clock
	[00002] [00008] [0x0000015]	    CALL                           A=3   B=1   C=2          ; var3 = var3()
	[00003] [00009] [0x0000020]	    JUMPIFNOTLT [0x0000002]        A=3   D=3                ; if var3 >= var2 then goto [B5] else goto [B4]

	# BLOCK 5 (B5) | PC 11 -> 12
	[00000] [00011] [0x000000D]	    GETTABLE                       A=2   B=1   C=0          ; var2 = var1[var0]
	[00001] [00012] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

	# BLOCK 4 (B4) | PC 13 -> 19
	[00000] [00013] [0x000000C]	    GETIMPORT [0x80000400]         A=3   D=2                ; var3 = os.clock
	[00001] [00015] [0x0000015]	    CALL                           A=3   B=1   C=2          ; var3 = var3()
	[00002] [00016] [0x0000027]	    ADDK                           A=2   B=3   C=3          ; var2 = var3 + 1
	[00003] [00017] [0x000000E]	    SETTABLE                       A=2   B=1   C=0          ; var1[var0] = var2
	[00004] [00018] [0x000000D]	    GETTABLE                       A=2   B=1   C=0          ; var2 = var1[var0]
	[00005] [00019] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = cached
local function damage(var0) --[[ Line: 14, Id: 1 ]]
	# Constants [5] (0x0000005)
		[0x0000000] : "Health"                       : type 3 [0x0000003]
		[0x0000001] : "Dead"                         : type 3 [0x0000003]
		[0x0000002] : "os"                           : type 3 [0x0000003]
		[0x0000003] : "clock"                        : type 3 [0x0000003]
		[0x0000004] : os.clock                       : type 4 [0x0000004]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x000001A]	    JUMPIFNOT                      A=0   D=13               ; if not var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 1 -> 4
	[00000] [00001] [0x000000F]	    GETTABLEKS [0x0000000]         A=1   B=0   C=90         ; var1 = var0.Health
	[00001] [00003] [0x0000004]	    LOADN                          A=2   D=0                ; var2 = 0
	[00002] [00004] [0x000001F]	    JUMPIFNOTLE [0x0000002]        A=1   D=9                ; if var1 > var2 then goto [B3] else goto [B2]

	# BLOCK 3 (B3) | PC 6 -> 8
	[00000] [00006] [0x000000F]	    GETTABLEKS [0x0000001]         A=1   B=0   C=15         ; var1 = var0.Dead
	[00001] [00008] [0x0000019]	    JUMPIF                         A=1   D=5                ; if var1 then goto [B2] else goto [B4]

	# BLOCK 4 (B4) | PC 9 -> 12
	[00000] [00009] [0x000000C]	    GETIMPORT [0x80200C00]         A=1   D=4                ; var1 = os.clock
	[00001] [00011] [0x0000015]	    CALL                           A=1   B=1   C=2          ; var1 = var1()
	[00002] [00012] [0x0000010]	    SETTABLEKS [0x0000001]         A=1   B=0   C=15         ; var0.Dead = var1

	# BLOCK 2 (B2) | PC 14 -> 14
	[00000] [00014] [0x0000016]	    RETURN                         A=0   B=2                ; return var0

end
[00002] [00002] [0x0000040]	    DUPCLOSURE                     A=1   D=1                ; var1 = damage
[00003] [00003] [0x000000C]	    GETIMPORT [0x40200000]         A=2   D=3                ; var2 = print
[00004] [00005] [0x0000006]	    MOVE                           A=3   B=0                ; var3 = var0
[00005] [00006] [0x0000035]	    NEWTABLE [0x0000000]           A=4   B=0                ; var4 = {}
[00006] [00008] [0x0000035]	    NEWTABLE [0x0000000]           A=5   B=0                ; var5 = {}
[00007] [00010] [0x0000015]	    CALL                           A=3   B=3   C=0          ; ... = var3(var4, var5)
[00008] [00011] [0x0000015]	    CALL                           A=2   B=0   C=1          ; var2(...)
[00009] [00012] [0x000000C]	    GETIMPORT [0x40200000]         A=2   D=3                ; var2 = print
[00010] [00014] [0x0000006]	    MOVE                           A=3   B=1                ; var3 = var1
[00011] [00015] [0x0000036]	    DUPTABLE                       A=4   D=6                ; var4 = { Health = 0 }
[00012] [00016] [0x0000015]	    CALL                           A=3   B=2   C=0          ; ... = var3(var4)
[00013] [00017] [0x0000015]	    CALL                           A=2   B=0   C=1          ; var2(...)
[00014] [00018] [0x0000016]	    RETURN                         A=0   B=1                ; return
