; Luau version: 9
; Types version: 3
; Magic key: 1
; Main function id: 1
; Total functions: 2

; Constants [1]
	[0x0000000] : <closure->accumulate>          ; LBC_CONSTANT_CLOSURE (0x06)

; Block 0 [ENTRY] [EXIT] (B0) | PC 0 -> 2
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function accumulate(var0, var1) --[[ Line: 1, Id: 0 ]]
	; Constants [6]
		[0x0000000] : "Heartbeat"                    ; LBC_CONSTANT_STRING (0x03)
		[0x0000001] : "Wait"                         ; LBC_CONSTANT_STRING (0x03)
		[0x0000002] : "math"                         ; LBC_CONSTANT_STRING (0x03)
		[0x0000003] : "random"                       ; LBC_CONSTANT_STRING (0x03)
		[0x0000004] : math.random                    ; LBC_CONSTANT_IMPORT (0x04)
		[0x0000005] : 2                              ; LBC_CONSTANT_NUMBER (0x02)

	; Block 0 [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x0000004]	    LOADN                          A=2  D=0                 ; var2 = 0

	; Block 1 (B1) | PC 1 -> 1
	[00000] [00001] [0x000001A]	    JUMPIFNOT                      A=0  D=10                ; if not var0 then goto #12 [B4] else goto #2 [B2]

	; Block 2 (B2) | PC 2 -> 9
	[00000] [00002] [0x000000F]	    GETTABLEKS [0x0000000]         A=3  B=1  C=253          ; var3 = var1.Heartbeat
	[00001] [00004] [0x0000014]	    NAMECALL [0x0000001]           A=3  B=3  C=247          ; <self>var4 = var3 -> var3.Wait -- Next CALL instruction must be a __namecall invoker
	[00002] [00006] [0x0000015]	    CALL                           A=3  B=2  C=2            ; var3 = var3(var4)
	[00003] [00007] [0x0000021]	    ADD                            A=2  B=2  C=3            ; var2 = var2 + var3
	[00004] [00008] [0x0000004]	    LOADN                          A=4  D=10                ; var4 = 10
	[00005] [00009] [0x000001D]	    JUMPIFLT [0x0000002]           A=4  D=2                 ; if var4 < var2 then goto #12 [B4] else goto #11 [B3]

	; Block 3 (B3) | PC 11 -> 11
	[00000] [00011] [0x0000018]	    JUMPBACK                       D=-11                    ; goto #1 [B1] (loop); continue through #12 [B4]

	; Block 4 (B4) | PC 12 -> 17
	[00000] [00012] [0x000000C]	    GETIMPORT [0x80200C00]         A=3  D=4                 ; var3 = math.random
	[00001] [00014] [0x0000015]	    CALL                           A=3  B=1  C=2            ; var3 = var3()
	[00002] [00015] [0x0000021]	    ADD                            A=2  B=2  C=3            ; var2 = var2 + var3
	[00003] [00016] [0x0000004]	    LOADN                          A=4  D=20                ; var4 = 20
	[00004] [00017] [0x000001D]	    JUMPIFLT [0x0000002]           A=4  D=2                 ; if var4 < var2 then goto #20 [B6] else goto #19 [B5]

	; Block 5 (B5) | PC 19 -> 19
	[00000] [00019] [0x0000018]	    JUMPBACK                       D=-8                     ; goto #12 [B4] (loop); continue through #20 [B6]

	; Block 6 (B6) | PC 20 -> 23
	[00000] [00020] [0x0000004]	    LOADN                          A=5  D=1                 ; var5 = 1
	[00001] [00021] [0x0000004]	    LOADN                          A=3  D=5                 ; var3 = 5
	[00002] [00022] [0x0000004]	    LOADN                          A=4  D=1                 ; var4 = 1
	[00003] [00023] [0x0000038]	    FORNPREP                       A=3  D=3                 ; for var5 = var5, var3, var4 do goto #24 [B7]

	; Block 7 (B7) | PC 24 -> 25
	[00000] [00024] [0x0000029]	    MULK                           A=6  B=5                 ; var6 = var5 * 2
	[00001] [00025] [0x0000021]	    ADD                            A=2  B=2  C=6            ; var2 = var2 + var6

	; Block 8 (B8) | PC 26 -> 26
	[00000] [00026] [0x0000039]	    FORNLOOP                       A=3  D=-3                ; var5 += var4; if var5 <= var3 then goto #24 [B7] else goto #27 [B9]

	; Block 9 [EXIT] (B9) | PC 27 -> 27
	[00000] [00027] [0x0000016]	    RETURN                         A=2  B=2                 ; return var2
end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0  D=0                 ; var0 = accumulate
[00002] [00002] [0x0000016]	    RETURN                         A=0  B=2                 ; return var0