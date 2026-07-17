
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 4 (0x0000004)
# Total functions: 5 (0x0000004)

# Constants [9] (0x0000009)
	[0x0000000] : goto allTrue on line 1         : type 6 [0x0000006]
	[0x0000001] : goto anyTrue on line 5         : type 6 [0x0000006]
	[0x0000002] : goto mixed on line 9           : type 6 [0x0000006]
	[0x0000003] : goto fallback on line 14       : type 6 [0x0000006]
	[0x0000004] : "print"                        : type 3 [0x0000003]
	[0x0000005] : print                          : type 4 [0x0000004]
	[0x0000006] : "value"                        : type 3 [0x0000003]
	[0x0000007] : 7                              : type 2 [0x0000002]
	[0x0000008] : { value = 7 }                  : type 8 [0x0000008]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 39
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function allTrue(var0, var1, var2, var3) --[[ Line: 1, Id: 0 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000006]	    MOVE                           A=4   B=0                ; var4 = var0
	[00001] [00001] [0x000001A]	    JUMPIFNOT                      A=4   D=5                ; if not var4 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 2 -> 3
	[00000] [00002] [0x0000006]	    MOVE                           A=4   B=1                ; var4 = var1
	[00001] [00003] [0x000001A]	    JUMPIFNOT                      A=4   D=3                ; if not var4 then goto [B3] else goto [B2]

	# BLOCK 3 (B3) | PC 4 -> 5
	[00000] [00004] [0x0000006]	    MOVE                           A=4   B=2                ; var4 = var2
	[00001] [00005] [0x000001A]	    JUMPIFNOT                      A=4   D=1                ; if not var4 then goto [B4] else goto [B2]

	# BLOCK 4 (B4) | PC 6 -> 6
	[00000] [00006] [0x0000006]	    MOVE                           A=4   B=3                ; var4 = var3

	# BLOCK 2 (B2) | PC 7 -> 7
	[00000] [00007] [0x0000016]	    RETURN                         A=4   B=2                ; return var4

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = allTrue
local function anyTrue(var0, var1, var2) --[[ Line: 5, Id: 1 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000006]	    MOVE                           A=3   B=0                ; var3 = var0
	[00001] [00001] [0x0000019]	    JUMPIF                         A=3   D=3                ; if var3 then goto [B2] else goto [B1]

	# BLOCK 1 (B1) | PC 2 -> 3
	[00000] [00002] [0x0000006]	    MOVE                           A=3   B=1                ; var3 = var1
	[00001] [00003] [0x0000019]	    JUMPIF                         A=3   D=1                ; if var3 then goto [B2] else goto [B3]

	# BLOCK 3 (B3) | PC 4 -> 4
	[00000] [00004] [0x0000006]	    MOVE                           A=3   B=2                ; var3 = var2

	# BLOCK 2 (B2) | PC 5 -> 5
	[00000] [00005] [0x0000016]	    RETURN                         A=3   B=2                ; return var3

end
[00002] [00002] [0x0000040]	    DUPCLOSURE                     A=1   D=1                ; var1 = anyTrue
local function mixed(var0, var1, var2) --[[ Line: 9, Id: 2 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 2
	[00000] [00000] [0x0000003]	    LOADB                          A=3   B=0   C=0          ; var3 = false
	[00001] [00001] [0x0000004]	    LOADN                          A=4   D=0                ; var4 = 0
	[00002] [00002] [0x0000020]	    JUMPIFNOTLT [0x0000000]        A=4   D=9                ; if var4 >= var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 4 -> 6
	[00000] [00004] [0x0000003]	    LOADB                          A=3   B=0   C=0          ; var3 = false
	[00001] [00005] [0x0000004]	    LOADN                          A=4   D=10               ; var4 = 10
	[00002] [00006] [0x0000020]	    JUMPIFNOTLT [0x0000004]        A=1   D=5                ; if var1 >= var4 then goto [B3] else goto [B2]

	# BLOCK 3 (B3) | PC 8 -> 8
	[00000] [00008] [0x000004D]	    JUMPXEQKNIL [0x80000000]       A=2   D=2                ; if var2 ~= nil then goto [B5] else goto [B4]

	# BLOCK 4 (B4) | PC 10 -> 10
	[00000] [00010] [0x0000003]	    LOADB                          A=3   B=0   C=1          ; var3 = false ; goto [B2]

	# BLOCK 5 (B5) | PC 11 -> 11
	[00000] [00011] [0x0000003]	    LOADB                          A=3   B=1   C=0          ; var3 = true

	# BLOCK 2 (B2) | PC 12 -> 12
	[00000] [00012] [0x0000016]	    RETURN                         A=3   B=2                ; return var3

end
[00003] [00003] [0x0000040]	    DUPCLOSURE                     A=2   D=2                ; var2 = mixed
local function fallback(var0, var1, var2) --[[ Line: 14, Id: 3 ]]
	# Constants [5] (0x0000005)
		[0x0000000] : "typeof"                       : type 3 [0x0000003]
		[0x0000001] : typeof                         : type 4 [0x0000004]
		[0x0000002] : "table"                        : type 3 [0x0000003]
		[0x0000003] : "value"                        : type 3 [0x0000003]
		[0x0000004] : "default"                      : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000006]	    MOVE                           A=3   B=0                ; var3 = var0
	[00001] [00001] [0x0000019]	    JUMPIF                         A=3   D=14               ; if var3 then goto [B2] else goto [B1]

	# BLOCK 1 (B1) | PC 2 -> 2
	[00000] [00002] [0x000001A]	    JUMPIFNOT                      A=1   D=10               ; if not var1 then goto [B3] else goto [B4]

	# BLOCK 3 (B3) | PC 3 -> 8
	[00000] [00003] [0x0000049]	    FASTCALL1                      A=44  B=1   C=3          ; ... = typeof(var1) -- Uses args and results from the CALL instruction located in [00005]. If successful goto >= [00006]
	[00001] [00004] [0x0000006]	    MOVE                           A=5   B=1                ; var5 = var1
	[00002] [00005] [0x000000C]	    GETIMPORT [0x40000000]         A=4   D=1                ; var4 = typeof
	[00003] [00007] [0x0000015]	    CALL                           A=4   B=2   C=2          ; var4 = var4(var5)
	[00004] [00008] [0x0000050]	    JUMPXEQKS [0x80000002]         A=4   D=4                ; if var4 ~= "table" then goto [B4] else goto [B5]

	# BLOCK 5 (B5) | PC 10 -> 12
	[00000] [00010] [0x000000F]	    GETTABLEKS [0x0000003]         A=3   B=1   C=204        ; var3 = var1.value
	[00001] [00012] [0x0000019]	    JUMPIF                         A=3   D=3                ; if var3 then goto [B2] else goto [B4]

	# BLOCK 4 (B4) | PC 13 -> 14
	[00000] [00013] [0x0000006]	    MOVE                           A=3   B=2                ; var3 = var2
	[00001] [00014] [0x0000019]	    JUMPIF                         A=3   D=1                ; if var3 then goto [B2] else goto [B6]

	# BLOCK 6 (B6) | PC 15 -> 15
	[00000] [00015] [0x0000005]	    LOADK                          A=3   D=4                ; var3 = "default"

	# BLOCK 2 (B2) | PC 16 -> 16
	[00000] [00016] [0x0000016]	    RETURN                         A=3   B=2                ; return var3

end
[00004] [00004] [0x0000040]	    DUPCLOSURE                     A=3   D=3                ; var3 = fallback
[00005] [00005] [0x000000C]	    GETIMPORT [0x40400000]         A=4   D=5                ; var4 = print
[00006] [00007] [0x0000006]	    MOVE                           A=5   B=0                ; var5 = var0
[00007] [00008] [0x0000004]	    LOADN                          A=6   D=1                ; var6 = 1
[00008] [00009] [0x0000004]	    LOADN                          A=7   D=2                ; var7 = 2
[00009] [00010] [0x0000004]	    LOADN                          A=8   D=3                ; var8 = 3
[00010] [00011] [0x0000004]	    LOADN                          A=9   D=4                ; var9 = 4
[00011] [00012] [0x0000015]	    CALL                           A=5   B=5   C=0          ; ... = var5(var6, var7, var8, var9)
[00012] [00013] [0x0000015]	    CALL                           A=4   B=0   C=1          ; var4(...)
[00013] [00014] [0x000000C]	    GETIMPORT [0x40400000]         A=4   D=5                ; var4 = print
[00014] [00016] [0x0000006]	    MOVE                           A=5   B=1                ; var5 = var1
[00015] [00017] [0x0000002]	    LOADNIL                        A=6                      ; var6 = nil
[00016] [00018] [0x0000003]	    LOADB                          A=7   B=0   C=0          ; var7 = false
[00017] [00019] [0x0000004]	    LOADN                          A=8   D=5                ; var8 = 5
[00018] [00020] [0x0000015]	    CALL                           A=5   B=4   C=0          ; ... = var5(var6, var7, var8)
[00019] [00021] [0x0000015]	    CALL                           A=4   B=0   C=1          ; var4(...)
[00020] [00022] [0x000000C]	    GETIMPORT [0x40400000]         A=4   D=5                ; var4 = print
[00021] [00024] [0x0000006]	    MOVE                           A=5   B=2                ; var5 = var2
[00022] [00025] [0x0000004]	    LOADN                          A=6   D=5                ; var6 = 5
[00023] [00026] [0x0000004]	    LOADN                          A=7   D=3                ; var7 = 3
[00024] [00027] [0x0000035]	    NEWTABLE [0x0000000]           A=8   B=0                ; var8 = {}
[00025] [00029] [0x0000015]	    CALL                           A=5   B=4   C=0          ; ... = var5(var6, var7, var8)
[00026] [00030] [0x0000015]	    CALL                           A=4   B=0   C=1          ; var4(...)
[00027] [00031] [0x000000C]	    GETIMPORT [0x40400000]         A=4   D=5                ; var4 = print
[00028] [00033] [0x0000006]	    MOVE                           A=5   B=3                ; var5 = var3
[00029] [00034] [0x0000002]	    LOADNIL                        A=6                      ; var6 = nil
[00030] [00035] [0x0000036]	    DUPTABLE                       A=7   D=8                ; var7 = { value = 7 }
[00031] [00036] [0x0000002]	    LOADNIL                        A=8                      ; var8 = nil
[00032] [00037] [0x0000015]	    CALL                           A=5   B=4   C=0          ; ... = var5(var6, var7, var8)
[00033] [00038] [0x0000015]	    CALL                           A=4   B=0   C=1          ; var4(...)
[00034] [00039] [0x0000016]	    RETURN                         A=0   B=1                ; return
