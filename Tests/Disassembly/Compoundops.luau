# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 0 (0x0000000)
# Total functions: 1 (0x0000000)

# Constants [7] (0x0000007)
	[0x0000000] : 5                              : type 2 [0x0000002]
	[0x0000001] : 3                              : type 2 [0x0000002]
	[0x0000002] : 2                              : type 2 [0x0000002]
	[0x0000003] : 4                              : type 2 [0x0000002]
	[0x0000004] : "!"                            : type 3 [0x0000003]
	[0x0000005] : "print"                        : type 3 [0x0000003]
	[0x0000006] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 15
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x0000004]	    LOADN                          A=0   D=10               ; var0 = 10
[00002] [00002] [0x0000027]	    ADDK                           A=0   B=0   C=0          ; var0 = var0 + 5
[00003] [00003] [0x0000028]	    SUBK                           A=0   B=0   C=1          ; var0 = var0 - 3
[00004] [00004] [0x0000029]	    MULK                           A=0   B=0   C=2          ; var0 = var0 * 2
[00005] [00005] [0x000002A]	    DIVK                           A=0   B=0   C=3          ; var0 = var0 / 4
[00006] [00006] [0x000002B]	    MODK                           A=0   B=0   C=1          ; var0 = var0 % 3
[00007] [00007] [0x000002C]	    POWK                           A=0   B=0   C=2          ; var0 = var0 ^ 2
[00008] [00008] [0x0000006]	    MOVE                           A=1   B=0                ; var1 = var0
[00009] [00009] [0x0000005]	    LOADK                          A=2   D=4                ; var2 = "!"
[00010] [00010] [0x0000031]	    CONCAT                         A=0   B=1   C=2          ; var0 = var1 .. var2
[00011] [00011] [0x000000C]	    GETIMPORT [0x40500000]         A=1   D=6                ; var1 = print
[00012] [00013] [0x0000006]	    MOVE                           A=2   B=0                ; var2 = var0
[00013] [00014] [0x0000015]	    CALL                           A=1   B=2   C=1          ; var1(var2)
[00014] [00015] [0x0000016]	    RETURN                         A=0   B=1                ; return