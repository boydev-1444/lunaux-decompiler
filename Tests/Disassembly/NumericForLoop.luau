; Luau version: 11
; Types version: 3
; Magic key: 1
; Main function id: 0
; Total functions: 1

; Constants [8]
	[0x0000000] : "print"                        ; LBC_CONSTANT_STRING (0x03)
	[0x0000001] : print                          ; LBC_CONSTANT_IMPORT (0x04)
	[0x0000002] : "Hello World!"                 ; LBC_CONSTANT_STRING (0x03)
	[0x0000003] : 2                              ; LBC_CONSTANT_NUMBER (0x02)
	[0x0000004] : 0                              ; LBC_CONSTANT_NUMBER (0x02)
	[0x0000005] : "i % 2 ~= 0"                   ; LBC_CONSTANT_STRING (0x03)
	[0x0000006] : "Intermediate statement"       ; LBC_CONSTANT_STRING (0x03)
	[0x0000007] : "Goodbye World!"               ; LBC_CONSTANT_STRING (0x03)

; Block 0 [ENTRY] (B0) | PC 0 -> 8
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=0  D=1                 ; var0 = print
[00002] [00003] [0x0000005]	    LOADK                          A=1  D=2                 ; var1 = "Hello World!"
[00003] [00004] [0x0000015]	    CALL                           A=0  B=2  C=1            ; var0(var1)
[00004] [00005] [0x0000004]	    LOADN                          A=2  D=1                 ; var2 = 1
[00005] [00006] [0x0000004]	    LOADN                          A=0  D=20                ; var0 = 20
[00006] [00007] [0x0000004]	    LOADN                          A=1  D=1                 ; var1 = 1
[00007] [00008] [0x0000038]	    FORNPREP                       A=0  D=20                ; for var2 = var2, var0, var1 do goto #9 [B1]

; Block 1 (B1) | PC 9 -> 14
[00000] [00009] [0x000000C]	    GETIMPORT [0x40000000]         A=3  D=1                 ; var3 = print
[00001] [00011] [0x0000006]	    MOVE                           A=4  B=2                 ; var4 = var2
[00002] [00012] [0x0000015]	    CALL                           A=3  B=2  C=1            ; var3(var4)
[00003] [00013] [0x000002B]	    MODK                           A=3  B=2                 ; var3 = var2 % 2
[00004] [00014] [0x000004F]	    JUMPXEQKN [0x0000004]          A=3  D=13                ; if var3 == 0 then goto #16 [B2] else goto #28 [B3]

; Block 2 (B2) | PC 16 -> 27
[00000] [00016] [0x000000C]	    GETIMPORT [0x40000000]         A=3  D=1                 ; var3 = print
[00001] [00018] [0x0000005]	    LOADK                          A=4  D=5                 ; var4 = "i % 2 ~= 0"
[00002] [00019] [0x0000015]	    CALL                           A=3  B=2  C=1            ; var3(var4)
[00003] [00020] [0x000000C]	    GETIMPORT [0x40000000]         A=3  D=1                 ; var3 = print
[00004] [00022] [0x0000005]	    LOADK                          A=4  D=6                 ; var4 = "Intermediate statement"
[00005] [00023] [0x0000015]	    CALL                           A=3  B=2  C=1            ; var3(var4)
[00006] [00024] [0x000000C]	    GETIMPORT [0x40000000]         A=3  D=1                 ; var3 = print
[00007] [00026] [0x0000005]	    LOADK                          A=4  D=7                 ; var4 = "Goodbye World!"
[00008] [00027] [0x0000015]	    CALL                           A=3  B=2  C=1            ; var3(var4)

; Block 3 (B3) | PC 28 -> 28
[00000] [00028] [0x0000039]	    FORNLOOP                       A=0  D=-20               ; var2 += var1; if var2 <= var0 then goto #9 [B1] else goto #29 [B4]

; Block 4 [EXIT] (B4) | PC 29 -> 29
[00000] [00029] [0x0000016]	    RETURN                         A=0  B=1                 ; return