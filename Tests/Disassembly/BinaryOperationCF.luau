; Luau version: 11
; Types version: 3
; Magic key: 1
; Main function id: 0
; Total functions: 1

; Constants [27]
	[0x0000000] : "IsAdmin"                      ; LBC_CONSTANT_STRING (0x03)
	[0x0000001] : IsAdmin                        ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000002] : "HasKeycard"                   ; LBC_CONSTANT_STRING (0x03)
	[0x0000003] : HasKeycard                     ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000004] : "ACCESS_GRANTED"               ; LBC_CONSTANT_STRING (0x03)
	[0x0000005] : "IsGuest"                      ; LBC_CONSTANT_STRING (0x03)
	[0x0000006] : IsGuest                        ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000007] : "LIMITED_ACCESS"               ; LBC_CONSTANT_STRING (0x03)
	[0x0000008] : "NO_KEYCARD"                   ; LBC_CONSTANT_STRING (0x03)
	[0x0000009] : "IsBanned"                     ; LBC_CONSTANT_STRING (0x03)
	[0x000000A] : IsBanned                       ; LBC_CONSTANT_IMPORT (0x04)
	[0x000000B] : "BANNED"                       ; LBC_CONSTANT_STRING (0x03)
	[0x000000C] : "Coins"                        ; LBC_CONSTANT_STRING (0x03)
	[0x000000D] : Coins                          ; LBC_CONSTANT_IMPORT (0x04)
	[0x000000E] : "OwnsVIP"                      ; LBC_CONSTANT_STRING (0x03)
	[0x000000F] : OwnsVIP                        ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000010] : "VIP_PLAYER"                   ; LBC_CONSTANT_STRING (0x03)
	[0x0000011] : "RICH_PLAYER"                  ; LBC_CONSTANT_STRING (0x03)
	[0x0000012] : "Level"                        ; LBC_CONSTANT_STRING (0x03)
	[0x0000013] : Level                          ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000014] : "HasBadge"                     ; LBC_CONSTANT_STRING (0x03)
	[0x0000015] : HasBadge                       ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000016] : "PRO_PLAYER"                   ; LBC_CONSTANT_STRING (0x03)
	[0x0000017] : "EXPERIENCED_PLAYER"           ; LBC_CONSTANT_STRING (0x03)
	[0x0000018] : "NEW_PLAYER"                   ; LBC_CONSTANT_STRING (0x03)
	[0x0000019] : "print"                        ; LBC_CONSTANT_STRING (0x03)
	[0x000001A] : print                          ; LBC_CONSTANT_IMPORT (0x04)

; Block 0 [ENTRY] (B0) | PC 0 -> 3
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=1  D=1                 ; var1 = IsAdmin
[00002] [00003] [0x000001A]	    JUMPIFNOT                      A=1  D=12                ; if not var1 then goto #16 [B6] else goto #4 [B1]

; Block 1 (B1) | PC 4 -> 6
[00000] [00004] [0x000000C]	    GETIMPORT [0x40200000]         A=1  D=3                 ; var1 = HasKeycard
[00001] [00006] [0x000001A]	    JUMPIFNOT                      A=1  D=2                 ; if not var1 then goto #9 [B3] else goto #7 [B2]

; Block 2 (B2) | PC 7 -> 8
[00000] [00007] [0x0000005]	    LOADK                          A=0  D=4                 ; var0 = "ACCESS_GRANTED"
[00001] [00008] [0x0000017]	    JUMP                           D=37                     ; goto #46 [B17]

; Block 3 (B3) | PC 9 -> 11
[00000] [00009] [0x000000C]	    GETIMPORT [0x40500000]         A=1  D=6                 ; var1 = IsGuest
[00001] [00011] [0x000001A]	    JUMPIFNOT                      A=1  D=2                 ; if not var1 then goto #14 [B5] else goto #12 [B4]

; Block 4 (B4) | PC 12 -> 13
[00000] [00012] [0x0000005]	    LOADK                          A=0  D=7                 ; var0 = "LIMITED_ACCESS"
[00001] [00013] [0x0000017]	    JUMP                           D=32                     ; goto #46 [B17]

; Block 5 (B5) | PC 14 -> 15
[00000] [00014] [0x0000005]	    LOADK                          A=0  D=8                 ; var0 = "NO_KEYCARD"
[00001] [00015] [0x0000017]	    JUMP                           D=30                     ; goto #46 [B17]

; Block 6 (B6) | PC 16 -> 18
[00000] [00016] [0x000000C]	    GETIMPORT [0x40900000]         A=1  D=10                ; var1 = IsBanned
[00001] [00018] [0x000001A]	    JUMPIFNOT                      A=1  D=2                 ; if not var1 then goto #21 [B8] else goto #19 [B7]

; Block 7 (B7) | PC 19 -> 20
[00000] [00019] [0x0000005]	    LOADK                          A=0  D=11                ; var0 = "BANNED"
[00001] [00020] [0x0000017]	    JUMP                           D=25                     ; goto #46 [B17]

; Block 8 (B8) | PC 21 -> 24
[00000] [00021] [0x000000C]	    GETIMPORT [0x40C00000]         A=1  D=13                ; var1 = Coins
[00001] [00023] [0x0000004]	    LOADN                          A=2  D=1000              ; var2 = 1000
[00002] [00024] [0x000001F]	    JUMPIFNOTLE [0x0000001]        A=2  D=8                 ; if var2 <= var1 then goto #26 [B9] else goto #33 [B12]

; Block 9 (B9) | PC 26 -> 28
[00000] [00026] [0x000000C]	    GETIMPORT [0x40E00000]         A=1  D=15                ; var1 = OwnsVIP
[00001] [00028] [0x000001A]	    JUMPIFNOT                      A=1  D=2                 ; if not var1 then goto #31 [B11] else goto #29 [B10]

; Block 10 (B10) | PC 29 -> 30
[00000] [00029] [0x0000005]	    LOADK                          A=0  D=16                ; var0 = "VIP_PLAYER"
[00001] [00030] [0x0000017]	    JUMP                           D=15                     ; goto #46 [B17]

; Block 11 (B11) | PC 31 -> 32
[00000] [00031] [0x0000005]	    LOADK                          A=0  D=17                ; var0 = "RICH_PLAYER"
[00001] [00032] [0x0000017]	    JUMP                           D=13                     ; goto #46 [B17]

; Block 12 (B12) | PC 33 -> 36
[00000] [00033] [0x000000C]	    GETIMPORT [0x41200000]         A=1  D=19                ; var1 = Level
[00001] [00035] [0x0000004]	    LOADN                          A=2  D=50                ; var2 = 50
[00002] [00036] [0x000001F]	    JUMPIFNOTLE [0x0000001]        A=2  D=8                 ; if var2 <= var1 then goto #38 [B13] else goto #45 [B16]

; Block 13 (B13) | PC 38 -> 40
[00000] [00038] [0x000000C]	    GETIMPORT [0x41400000]         A=1  D=21                ; var1 = HasBadge
[00001] [00040] [0x000001A]	    JUMPIFNOT                      A=1  D=2                 ; if not var1 then goto #43 [B15] else goto #41 [B14]

; Block 14 (B14) | PC 41 -> 42
[00000] [00041] [0x0000005]	    LOADK                          A=0  D=22                ; var0 = "PRO_PLAYER"
[00001] [00042] [0x0000017]	    JUMP                           D=3                      ; goto #46 [B17]

; Block 15 (B15) | PC 43 -> 44
[00000] [00043] [0x0000005]	    LOADK                          A=0  D=23                ; var0 = "EXPERIENCED_PLAYER"
[00001] [00044] [0x0000017]	    JUMP                           D=1                      ; goto #46 [B17]

; Block 16 (B16) | PC 45 -> 45
[00000] [00045] [0x0000005]	    LOADK                          A=0  D=24                ; var0 = "NEW_PLAYER"

; Block 17 [EXIT] (B17) | PC 46 -> 50
[00000] [00046] [0x000000C]	    GETIMPORT [0x41900000]         A=1  D=26                ; var1 = print
[00001] [00048] [0x0000006]	    MOVE                           A=2  B=0                 ; var2 = var0
[00002] [00049] [0x0000015]	    CALL                           A=1  B=2  C=1            ; var1(var2)
[00003] [00050] [0x0000016]	    RETURN                         A=0  B=1                 ; return