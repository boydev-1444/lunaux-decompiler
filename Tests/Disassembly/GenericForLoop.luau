
# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 0 (0x0000000)
# Total functions: 1 (0x0000000)

# Constants [6] (0x0000006)
	[0x0000000] : "print"                        : type 3 [0x0000003]
	[0x0000001] : print                          : type 4 [0x0000004]
	[0x0000002] : "Hello World!"                 : type 3 [0x0000003]
	[0x0000003] : "pairs"                        : type 3 [0x0000003]
	[0x0000004] : pairs                          : type 4 [0x0000004]
	[0x0000005] : "Goodbye World!"               : type 3 [0x0000003]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 10
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=0   D=1                ; var0 = print
[00002] [00003] [0x0000005]	    LOADK                          A=1   D=2                ; var1 = "Hello World!"
[00003] [00004] [0x0000015]	    CALL                           A=0   B=2   C=1          ; var0(var1)
[00004] [00005] [0x000000C]	    GETIMPORT [0x40300000]         A=0   D=4                ; var0 = pairs
[00005] [00007] [0x0000035]	    NEWTABLE [0x0000000]           A=1   B=0                ; var1 = {}
[00006] [00009] [0x0000015]	    CALL                           A=0   B=2   C=4          ; var0, var1, var2 = var0(var1)
[00007] [00010] [0x000003D]	    FORGPREP_NEXT                  A=0   D=5                ; for var3->... in var0, var1, var2 do goto [B2]

# BLOCK 1 (B1) | PC 11 -> 15
[00000] [00011] [0x000000C]	    GETIMPORT [0x40000000]         A=5   D=1                ; var5 = print
[00001] [00013] [0x000003F]	    GETVARARGS                     A=6   B=0                ; var6... = ...
[00002] [00014] [0x0000015]	    CALL                           A=5   B=0   C=1          ; var5(...)
[00003] [00015] [0x0000017]	    JUMP                           D=2                      ; goto [B3]

# BLOCK 2 (B2) | PC 16 -> 16
[00000] [00016] [0x000003A]	    FORGLOOP [0x0000002]           A=0   D=-6               ; var3, var4 = var0(var1, var2); if var3 ~= nil then goto [B1] else goto [B3]

# BLOCK 3 (B3) | PC 18 -> 22
[00000] [00018] [0x000000C]	    GETIMPORT [0x40000000]         A=0   D=1                ; var0 = print
[00001] [00020] [0x0000005]	    LOADK                          A=1   D=5                ; var1 = "Goodbye World!"
[00002] [00021] [0x0000015]	    CALL                           A=0   B=2   C=1          ; var0(var1)
[00003] [00022] [0x0000016]	    RETURN                         A=0   B=1                ; return
