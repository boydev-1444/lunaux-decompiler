; Luau version: 9
; Types version: 3
; Magic key: 1
; Main function id: 2
; Total functions: 3

; Constants [7]
	[0x0000000] : <closure->cached>              ; LBC_CONSTANT_CLOSURE (0x06)
	[0x0000001] : <closure->damage>              ; LBC_CONSTANT_CLOSURE (0x06)
	[0x0000002] : "print"                        ; LBC_CONSTANT_STRING (0x03)
	[0x0000003] : print                          ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000004] : "Health"                       ; LBC_CONSTANT_STRING (0x03)
	[0x0000005] : 0                              ; LBC_CONSTANT_NUMBER (0x02)
	[0x0000006] : { Health = 0 }                 ; LBC_CONSTANT_TABLE_WITH_CONSTANTS (0x08)

; Block 0 [ENTRY] [EXIT] (B0) | PC 0 -> 18
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function cached(var0, var1) --[[ Line: 1, Id: 0 ]]
	; Constants [4]
		[0x0000000] : "os"                           ; LBC_CONSTANT_STRING (0x03)
		[0x0000001] : "clock"                        ; LBC_CONSTANT_STRING (0x03)
		[0x0000002] : os.clock                       ; LBC_CONSTANT_IMPORT (0x04)
		[0x0000003] : 1                              ; LBC_CONSTANT_NUMBER (0x02)

	; Block 0 [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x0000019]	    JUMPIF                         A=0  D=2                 ; if var0 then goto #3 [B2] else goto #1 [B1]

	; Block 1 [EXIT] (B1) | PC 1 -> 2
	[00000] [00001] [0x0000002]	    LOADNIL                        A=2                      ; var2 = nil
	[00001] [00002] [0x0000016]	    RETURN                         A=2  B=2                 ; return var2

	; Block 2 (B2) | PC 3 -> 4
	[00000] [00003] [0x000000D]	    GETTABLE                       A=2  B=1  C=0            ; var2 = var1[var0]
	[00001] [00004] [0x000001A]	    JUMPIFNOT                      A=2  D=8                 ; if not var2 then goto #13 [B5] else goto #5 [B3]

	; Block 3 (B3) | PC 5 -> 9
	[00000] [00005] [0x000000D]	    GETTABLE                       A=2  B=1  C=0            ; var2 = var1[var0]
	[00001] [00006] [0x000000C]	    GETIMPORT [0x80000400]         A=3  D=2                 ; var3 = os.clock
	[00002] [00008] [0x0000015]	    CALL                           A=3  B=1  C=2            ; var3 = var3()
	[00003] [00009] [0x0000020]	    JUMPIFNOTLT [0x0000002]        A=3  D=3                 ; if var3 < var2 then goto #11 [B4] else goto #13 [B5]

	; Block 4 [EXIT] (B4) | PC 11 -> 12
	[00000] [00011] [0x000000D]	    GETTABLE                       A=2  B=1  C=0            ; var2 = var1[var0]
	[00001] [00012] [0x0000016]	    RETURN                         A=2  B=2                 ; return var2

	; Block 5 [EXIT] (B5) | PC 13 -> 19
	[00000] [00013] [0x000000C]	    GETIMPORT [0x80000400]         A=3  D=2                 ; var3 = os.clock
	[00001] [00015] [0x0000015]	    CALL                           A=3  B=1  C=2            ; var3 = var3()
	[00002] [00016] [0x0000027]	    ADDK                           A=2  B=3                 ; var2 = var3 + 1
	[00003] [00017] [0x000000E]	    SETTABLE                       A=2  B=1  C=0            ; var1[var0] = var2
	[00004] [00018] [0x000000D]	    GETTABLE                       A=2  B=1  C=0            ; var2 = var1[var0]
	[00005] [00019] [0x0000016]	    RETURN                         A=2  B=2                 ; return var2
end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0  D=0                 ; var0 = cached
local function damage(var0) --[[ Line: 14, Id: 1 ]]
	; Constants [5]
		[0x0000000] : "Health"                       ; LBC_CONSTANT_STRING (0x03)
		[0x0000001] : "Dead"                         ; LBC_CONSTANT_STRING (0x03)
		[0x0000002] : "os"                           ; LBC_CONSTANT_STRING (0x03)
		[0x0000003] : "clock"                        ; LBC_CONSTANT_STRING (0x03)
		[0x0000004] : os.clock                       ; LBC_CONSTANT_IMPORT (0x04)

	; Block 0 [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x000001A]	    JUMPIFNOT                      A=0  D=13                ; if not var0 then goto #14 [B4] else goto #1 [B1]

	; Block 1 (B1) | PC 1 -> 4
	[00000] [00001] [0x000000F]	    GETTABLEKS [0x0000000]         A=1  B=0  C=90           ; var1 = var0.Health
	[00001] [00003] [0x0000004]	    LOADN                          A=2  D=0                 ; var2 = 0
	[00002] [00004] [0x000001F]	    JUMPIFNOTLE [0x0000002]        A=1  D=9                 ; if var1 <= var2 then goto #6 [B2] else goto #14 [B4]

	; Block 2 (B2) | PC 6 -> 8
	[00000] [00006] [0x000000F]	    GETTABLEKS [0x0000001]         A=1  B=0  C=15           ; var1 = var0.Dead
	[00001] [00008] [0x0000019]	    JUMPIF                         A=1  D=5                 ; if var1 then goto #14 [B4] else goto #9 [B3]

	; Block 3 (B3) | PC 9 -> 12
	[00000] [00009] [0x000000C]	    GETIMPORT [0x80200C00]         A=1  D=4                 ; var1 = os.clock
	[00001] [00011] [0x0000015]	    CALL                           A=1  B=1  C=2            ; var1 = var1()
	[00002] [00012] [0x0000010]	    SETTABLEKS [0x0000001]         A=1  B=0  C=15           ; var0.Dead = var1

	; Block 4 [EXIT] (B4) | PC 14 -> 14
	[00000] [00014] [0x0000016]	    RETURN                         A=0  B=2                 ; return var0
end
[00002] [00002] [0x0000040]	    DUPCLOSURE                     A=1  D=1                 ; var1 = damage
[00003] [00003] [0x000000C]	    GETIMPORT [0x40200000]         A=2  D=3                 ; var2 = print
[00004] [00005] [0x0000006]	    MOVE                           A=3  B=0                 ; var3 = var0
[00005] [00006] [0x0000035]	    NEWTABLE [0x0000000]           A=4  B=0                 ; var4 = {}
[00006] [00008] [0x0000035]	    NEWTABLE [0x0000000]           A=5  B=0                 ; var5 = {}
[00007] [00010] [0x0000015]	    CALL                           A=3  B=3  C=0            ; ... = var3(var4, var5)
[00008] [00011] [0x0000015]	    CALL                           A=2  B=0  C=1            ; var2(...)
[00009] [00012] [0x000000C]	    GETIMPORT [0x40200000]         A=2  D=3                 ; var2 = print
[00010] [00014] [0x0000006]	    MOVE                           A=3  B=1                 ; var3 = var1
[00011] [00015] [0x0000036]	    DUPTABLE                       A=4  D=6                 ; var4 = { Health = 0 }
[00012] [00016] [0x0000015]	    CALL                           A=3  B=2  C=0            ; ... = var3(var4)
[00013] [00017] [0x0000015]	    CALL                           A=2  B=0  C=1            ; var2(...)
[00014] [00018] [0x0000016]	    RETURN                         A=0  B=1                 ; return