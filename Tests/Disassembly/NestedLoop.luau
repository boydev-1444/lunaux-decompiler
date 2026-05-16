# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 0 (0x0000000)
# Total functions: 1 (0x0000000)

# Constants [3] (0x0000003)
	[0x0000000] : 2                              : type 2 [0x0000002]
	[0x0000001] : "print"                        : type 3 [0x0000003]
	[0x0000002] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 4
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x0000004]	    LOADN                          A=2   D=1                ; var2 = 1
[00002] [00002] [0x0000004]	    LOADN                          A=0   D=3                ; var0 = 3
[00003] [00003] [0x0000004]	    LOADN                          A=1   D=1                ; var1 = 1
[00004] [00004] [0x0000038]	    FORNPREP                       A=0   D=13               ; for var2 = var2, var0, var1 do goto [B1]

# BLOCK 1 (B1) | PC 5 -> 8
[00000] [00005] [0x0000004]	    LOADN                          A=5   D=1                ; var5 = 1
[00001] [00006] [0x0000004]	    LOADN                          A=3   D=3                ; var3 = 3
[00002] [00007] [0x0000004]	    LOADN                          A=4   D=1                ; var4 = 1
[00003] [00008] [0x0000038]	    FORNPREP                       A=3   D=8                ; for var5 = var5, var3, var4 do goto [B3]

# BLOCK 3 (B3) | PC 9 -> 9
[00000] [00009] [0x000004F]	    JUMPXEQKN [0x0000000]          A=5   D=7                ; if var5 == 2 then goto [B5] else goto [B4]

# BLOCK 5 (B5) | PC 11 -> 15
[00000] [00011] [0x000000C]	    GETIMPORT [0x40100000]         A=6   D=2                ; var6 = print
[00001] [00013] [0x0000006]	    MOVE                           A=7   B=2                ; var7 = var2
[00002] [00014] [0x0000006]	    MOVE                           A=8   B=5                ; var8 = var5
[00003] [00015] [0x0000015]	    CALL                           A=6   B=3   C=1          ; var6(var7, var8)

# BLOCK 6 (B6) | PC 16 -> 16
[00000] [00016] [0x0000039]	    FORNLOOP                       A=3   D=-8               ; var5 += var4; if var5 <= var3 then goto [B3] else goto [B4]

# BLOCK 4 (B4) | PC 17 -> 17
[00000] [00017] [0x0000039]	    FORNLOOP                       A=0   D=-13              ; var2 += var1; if var2 <= var0 then goto [B1] else goto [B2]

# BLOCK 2 (B2) | PC 18 -> 18
[00000] [00018] [0x0000016]	    RETURN                         A=0   B=1                ; return