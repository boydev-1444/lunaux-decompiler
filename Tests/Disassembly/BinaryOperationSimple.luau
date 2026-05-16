# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 0 (0x0000000)
# Total functions: 1 (0x0000000)

# Constants [8] (0x0000008)
	[0x0000000] : "x"                            : type 3 [0x0000003]
	[0x0000001] : x                              : type 4 [0x0000004]
	[0x0000002] : "y"                            : type 3 [0x0000003]
	[0x0000003] : y                              : type 4 [0x0000004]
	[0x0000004] : "z"                            : type 3 [0x0000003]
	[0x0000005] : z                              : type 4 [0x0000004]
	[0x0000006] : "w"                            : type 3 [0x0000003]
	[0x0000007] : w                              : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 20
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=1   D=1                ; var1 = x
[00002] [00003] [0x000000C]	    GETIMPORT [0x40200000]         A=3   D=3                ; var3 = y
[00003] [00005] [0x000000C]	    GETIMPORT [0x40400000]         A=4   D=5                ; var4 = z
[00004] [00007] [0x0000021]	    ADD                            A=2   B=3   C=4          ; var2 = var3 + var4
[00005] [00008] [0x0000023]	    MUL                            A=0   B=1   C=2          ; var0 = var1 * var2
[00006] [00009] [0x000000C]	    GETIMPORT [0x40000000]         A=3   D=1                ; var3 = x
[00007] [00011] [0x000000C]	    GETIMPORT [0x40600000]         A=4   D=7                ; var4 = w
[00008] [00013] [0x0000022]	    SUB                            A=2   B=3   C=4          ; var2 = var3 - var4
[00009] [00014] [0x000000C]	    GETIMPORT [0x40200000]         A=4   D=3                ; var4 = y
[00010] [00016] [0x000000C]	    GETIMPORT [0x40400000]         A=5   D=5                ; var5 = z
[00011] [00018] [0x0000021]	    ADD                            A=3   B=4   C=5          ; var3 = var4 + var5
[00012] [00019] [0x0000023]	    MUL                            A=1   B=2   C=3          ; var1 = var2 * var3
[00013] [00020] [0x0000016]	    RETURN                         A=0   B=1                ; return