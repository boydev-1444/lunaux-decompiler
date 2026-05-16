# Luau version: 11 (0x000000B)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 0 (0x0000000)
# Total functions: 1 (0x0000000)

# Constants [27] (0x000001B)
	[0x0000000] : "IsAdmin"                      : type 3 [0x0000003]
	[0x0000001] : IsAdmin                        : type 4 [0x0000004]
	[0x0000002] : "HasKeycard"                   : type 3 [0x0000003]
	[0x0000003] : HasKeycard                     : type 4 [0x0000004]
	[0x0000004] : "ACCESS_GRANTED"               : type 3 [0x0000003]
	[0x0000005] : "IsGuest"                      : type 3 [0x0000003]
	[0x0000006] : IsGuest                        : type 4 [0x0000004]
	[0x0000007] : "LIMITED_ACCESS"               : type 3 [0x0000003]
	[0x0000008] : "NO_KEYCARD"                   : type 3 [0x0000003]
	[0x0000009] : "IsBanned"                     : type 3 [0x0000003]
	[0x000000A] : IsBanned                       : type 4 [0x0000004]
	[0x000000B] : "BANNED"                       : type 3 [0x0000003]
	[0x000000C] : "Coins"                        : type 3 [0x0000003]
	[0x000000D] : Coins                          : type 4 [0x0000004]
	[0x000000E] : "OwnsVIP"                      : type 3 [0x0000003]
	[0x000000F] : OwnsVIP                        : type 4 [0x0000004]
	[0x0000010] : "VIP_PLAYER"                   : type 3 [0x0000003]
	[0x0000011] : "RICH_PLAYER"                  : type 3 [0x0000003]
	[0x0000012] : "Level"                        : type 3 [0x0000003]
	[0x0000013] : Level                          : type 4 [0x0000004]
	[0x0000014] : "HasBadge"                     : type 3 [0x0000003]
	[0x0000015] : HasBadge                       : type 4 [0x0000004]
	[0x0000016] : "PRO_PLAYER"                   : type 3 [0x0000003]
	[0x0000017] : "EXPERIENCED_PLAYER"           : type 3 [0x0000003]
	[0x0000018] : "NEW_PLAYER"                   : type 3 [0x0000003]
	[0x0000019] : "print"                        : type 3 [0x0000003]
	[0x000001A] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 3
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=1   D=1                ; var1 = IsAdmin
[00002] [00003] [0x000001A]	    JUMPIFNOT                      A=1   D=12               ; if not var1 then goto [B1] else goto [B2]

# BLOCK 1 (B1) | PC 4 -> 6
[00000] [00004] [0x000000C]	    GETIMPORT [0x40200000]         A=1   D=3                ; var1 = HasKeycard
[00001] [00006] [0x000001A]	    JUMPIFNOT                      A=1   D=2                ; if not var1 then goto [B3] else goto [B4]

# BLOCK 3 (B3) | PC 7 -> 8
[00000] [00007] [0x0000005]	    LOADK                          A=0   D=4                ; var0 = "ACCESS_GRANTED"
[00001] [00008] [0x0000017]	    JUMP                           D=37                     ; goto [B5]

# BLOCK 4 (B4) | PC 9 -> 11
[00000] [00009] [0x000000C]	    GETIMPORT [0x40500000]         A=1   D=6                ; var1 = IsGuest
[00001] [00011] [0x000001A]	    JUMPIFNOT                      A=1   D=2                ; if not var1 then goto [B6] else goto [B7]

# BLOCK 6 (B6) | PC 12 -> 13
[00000] [00012] [0x0000005]	    LOADK                          A=0   D=7                ; var0 = "LIMITED_ACCESS"
[00001] [00013] [0x0000017]	    JUMP                           D=32                     ; goto [B5]

# BLOCK 7 (B7) | PC 14 -> 15
[00000] [00014] [0x0000005]	    LOADK                          A=0   D=8                ; var0 = "NO_KEYCARD"
[00001] [00015] [0x0000017]	    JUMP                           D=30                     ; goto [B5]

# BLOCK 2 (B2) | PC 16 -> 18
[00000] [00016] [0x000000C]	    GETIMPORT [0x40900000]         A=1   D=10               ; var1 = IsBanned
[00001] [00018] [0x000001A]	    JUMPIFNOT                      A=1   D=2                ; if not var1 then goto [B8] else goto [B9]

# BLOCK 8 (B8) | PC 19 -> 20
[00000] [00019] [0x0000005]	    LOADK                          A=0   D=11               ; var0 = "BANNED"
[00001] [00020] [0x0000017]	    JUMP                           D=25                     ; goto [B5]

# BLOCK 9 (B9) | PC 21 -> 24
[00000] [00021] [0x000000C]	    GETIMPORT [0x40C00000]         A=1   D=13               ; var1 = Coins
[00001] [00023] [0x0000004]	    LOADN                          A=2   D=1000             ; var2 = 1000
[00002] [00024] [0x000001F]	    JUMPIFNOTLE [0x0000001]        A=2   D=8                ; if var2 >= var1 then goto [B10] else goto [B11]

# BLOCK 10 (B10) | PC 26 -> 28
[00000] [00026] [0x000000C]	    GETIMPORT [0x40E00000]         A=1   D=15               ; var1 = OwnsVIP
[00001] [00028] [0x000001A]	    JUMPIFNOT                      A=1   D=2                ; if not var1 then goto [B12] else goto [B13]

# BLOCK 12 (B12) | PC 29 -> 30
[00000] [00029] [0x0000005]	    LOADK                          A=0   D=16               ; var0 = "VIP_PLAYER"
[00001] [00030] [0x0000017]	    JUMP                           D=15                     ; goto [B5]

# BLOCK 13 (B13) | PC 31 -> 32
[00000] [00031] [0x0000005]	    LOADK                          A=0   D=17               ; var0 = "RICH_PLAYER"
[00001] [00032] [0x0000017]	    JUMP                           D=13                     ; goto [B5]

# BLOCK 11 (B11) | PC 33 -> 36
[00000] [00033] [0x000000C]	    GETIMPORT [0x41200000]         A=1   D=19               ; var1 = Level
[00001] [00035] [0x0000004]	    LOADN                          A=2   D=50               ; var2 = 50
[00002] [00036] [0x000001F]	    JUMPIFNOTLE [0x0000001]        A=2   D=8                ; if var2 >= var1 then goto [B14] else goto [B15]

# BLOCK 14 (B14) | PC 38 -> 40
[00000] [00038] [0x000000C]	    GETIMPORT [0x41400000]         A=1   D=21               ; var1 = HasBadge
[00001] [00040] [0x000001A]	    JUMPIFNOT                      A=1   D=2                ; if not var1 then goto [B16] else goto [B17]

# BLOCK 16 (B16) | PC 41 -> 42
[00000] [00041] [0x0000005]	    LOADK                          A=0   D=22               ; var0 = "PRO_PLAYER"
[00001] [00042] [0x0000017]	    JUMP                           D=3                      ; goto [B5]

# BLOCK 17 (B17) | PC 43 -> 44
[00000] [00043] [0x0000005]	    LOADK                          A=0   D=23               ; var0 = "EXPERIENCED_PLAYER"
[00001] [00044] [0x0000017]	    JUMP                           D=1                      ; goto [B5]

# BLOCK 15 (B15) | PC 45 -> 45
[00000] [00045] [0x0000005]	    LOADK                          A=0   D=24               ; var0 = "NEW_PLAYER"

# BLOCK 5 (B5) | PC 46 -> 50
[00000] [00046] [0x000000C]	    GETIMPORT [0x41900000]         A=1   D=26               ; var1 = print
[00001] [00048] [0x0000006]	    MOVE                           A=2   B=0                ; var2 = var0
[00002] [00049] [0x0000015]	    CALL                           A=1   B=2   C=1          ; var1(var2)
[00003] [00050] [0x0000016]	    RETURN                         A=0   B=1                ; return