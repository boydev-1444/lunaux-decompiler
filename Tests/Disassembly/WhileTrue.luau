; Luau version: 11
; Types version: 3
; Magic key: 1
; Main function id: 0
; Total functions: 1

; Constants [3]
	[0x0000000] : "print"                        ; LBC_CONSTANT_STRING (0x03)
	[0x0000001] : print                          ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000002] : "Body"                         ; LBC_CONSTANT_STRING (0x03)

; Block 0 [ENTRY] (B0) | PC 0 -> 0
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...

; Block 1 (B1) | PC 1 -> 5
[00000] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=0  D=1                 ; var0 = print
[00001] [00003] [0x0000005]	    LOADK                          A=1  D=2                 ; var1 = "Body"
[00002] [00004] [0x0000015]	    CALL                           A=0  B=2  C=1            ; var0(var1)
[00003] [00005] [0x0000018]	    JUMPBACK                       D=-5                     ; goto #1 [B1] (loop); continue through #6 [B2]

; Block 2 [EXIT] (B2) | PC 6 -> 6
[00000] [00006] [0x0000016]	    RETURN                         A=0  B=1                 ; return