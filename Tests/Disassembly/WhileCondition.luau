; Luau version: 11
; Types version: 3
; Magic key: 1
; Main function id: 0
; Total functions: 1

; Constants [7]
	[0x0000000] : "print"                        ; LBC_CONSTANT_STRING (0x03)
	[0x0000001] : print                          ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000002] : "Before"                       ; LBC_CONSTANT_STRING (0x03)
	[0x0000003] : "condition"                    ; LBC_CONSTANT_STRING (0x03)
	[0x0000004] : condition                      ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000005] : "Body"                         ; LBC_CONSTANT_STRING (0x03)
	[0x0000006] : "After"                        ; LBC_CONSTANT_STRING (0x03)

; Block 0 [ENTRY] (B0) | PC 0 -> 4
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=0  D=1                 ; var0 = print
[00002] [00003] [0x0000005]	    LOADK                          A=1  D=2                 ; var1 = "Before"
[00003] [00004] [0x0000015]	    CALL                           A=0  B=2  C=1            ; var0(var1)

; Block 1 (B1) | PC 5 -> 7
[00000] [00005] [0x000000C]	    GETIMPORT [0x40300000]         A=0  D=4                 ; var0 = condition
[00001] [00007] [0x000001A]	    JUMPIFNOT                      A=0  D=5                 ; if not var0 then goto #13 [B3] else goto #8 [B2]

; Block 2 (B2) | PC 8 -> 12
[00000] [00008] [0x000000C]	    GETIMPORT [0x40000000]         A=0  D=1                 ; var0 = print
[00001] [00010] [0x0000005]	    LOADK                          A=1  D=5                 ; var1 = "Body"
[00002] [00011] [0x0000015]	    CALL                           A=0  B=2  C=1            ; var0(var1)
[00003] [00012] [0x0000018]	    JUMPBACK                       D=-8                     ; goto #5 [B1] (loop); continue through #13 [B3]

; Block 3 [EXIT] (B3) | PC 13 -> 17
[00000] [00013] [0x000000C]	    GETIMPORT [0x40000000]         A=0  D=1                 ; var0 = print
[00001] [00015] [0x0000005]	    LOADK                          A=1  D=6                 ; var1 = "After"
[00002] [00016] [0x0000015]	    CALL                           A=0  B=2  C=1            ; var0(var1)
[00003] [00017] [0x0000016]	    RETURN                         A=0  B=1                 ; return