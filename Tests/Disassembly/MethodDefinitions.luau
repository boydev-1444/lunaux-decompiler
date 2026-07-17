
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 4 (0x0000004)
# Total functions: 5 (0x0000004)

# Constants [13] (0x000000D)
	[0x0000000] : goto setup on line 3           : type 6 [0x0000006]
	[0x0000001] : "setup"                        : type 3 [0x0000003]
	[0x0000002] : goto run on line 8             : type 6 [0x0000006]
	[0x0000003] : "run"                          : type 3 [0x0000003]
	[0x0000004] : goto transform on line 12      : type 6 [0x0000006]
	[0x0000005] : "transform"                    : type 3 [0x0000003]
	[0x0000006] : goto static on line 16         : type 6 [0x0000006]
	[0x0000007] : "static"                       : type 3 [0x0000003]
	[0x0000008] : "speed"                        : type 3 [0x0000003]
	[0x0000009] : 16                             : type 2 [0x0000002]
	[0x000000A] : { speed = 16 }                 : type 8 [0x0000008]
	[0x000000B] : "print"                        : type 3 [0x0000003]
	[0x000000C] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 34
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x0000035]	    NEWTABLE [0x0000000]           A=0   B=3                ; var0 = {}
local function setup(var0, var1) --[[ Line: 3, Id: 0 ]]
	# Constants [2] (0x0000002)
		[0x0000000] : "ready"                        : type 3 [0x0000003]
		[0x0000001] : "config"                       : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x000004D]	    JUMPXEQKNIL [0x80000000]       A=1   D=2                ; if var1 ~= nil then goto [B2] else goto [B1]

	# BLOCK 1 (B1) | PC 2 -> 2
	[00000] [00002] [0x0000003]	    LOADB                          A=2   B=0   C=1          ; var2 = false ; goto [B3]

	# BLOCK 2 (B2) | PC 3 -> 3
	[00000] [00003] [0x0000003]	    LOADB                          A=2   B=1   C=0          ; var2 = true

	# BLOCK 3 (B3) | PC 4 -> 8
	[00000] [00004] [0x0000010]	    SETTABLEKS [0x0000000]         A=2   B=0   C=207        ; var0.ready = var2
	[00001] [00006] [0x0000010]	    SETTABLEKS [0x0000001]         A=1   B=0   C=185        ; var0.config = var1
	[00002] [00008] [0x0000016]	    RETURN                         A=0   B=1                ; return

end
[00002] [00003] [0x0000040]	    DUPCLOSURE                     A=1   D=0                ; var1 = setup
[00003] [00004] [0x0000010]	    SETTABLEKS [0x0000001]         A=1   B=0   C=249        ; var0.setup = var1
local function run(var0, var1) --[[ Line: 8, Id: 1 ]]
	# Constants [2] (0x0000002)
		[0x0000000] : "ready"                        : type 3 [0x0000003]
		[0x0000001] : "transform"                    : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 2
	[00000] [00000] [0x000000F]	    GETTABLEKS [0x0000000]         A=2   B=0   C=207        ; var2 = var0.ready
	[00001] [00002] [0x000001A]	    JUMPIFNOT                      A=2   D=4                ; if not var2 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 3 -> 6
	[00000] [00003] [0x0000006]	    MOVE                           A=4   B=1                ; var4 = var1
	[00001] [00004] [0x0000014]	    NAMECALL [0x0000001]           A=2   B=0   C=193        ; <self>var3 = var2 -> var0.transform -- Next CALL/FB instruction must be a __namecall invoker
	[00002] [00006] [0x0000015]	    CALL                           A=2   B=3   C=2          ; var2 = var2(var3, var4)

	# BLOCK 2 (B2) | PC 7 -> 7
	[00000] [00007] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00004] [00006] [0x0000040]	    DUPCLOSURE                     A=1   D=2                ; var1 = run
[00005] [00007] [0x0000010]	    SETTABLEKS [0x0000003]         A=1   B=0   C=54         ; var0.run = var1
local function transform(var0, var1) --[[ Line: 12, Id: 2 ]]
	# Constants [1] (0x0000001)
		[0x0000000] : 2                              : type 2 [0x0000002]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000029]	    MULK                           A=2   B=1   C=0          ; var2 = var1 * 2
	[00001] [00001] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00006] [00009] [0x0000040]	    DUPCLOSURE                     A=1   D=4                ; var1 = transform
[00007] [00010] [0x0000010]	    SETTABLEKS [0x0000005]         A=1   B=0   C=193        ; var0.transform = var1
local function static(var0, var1) --[[ Line: 16, Id: 3 ]]
	# No constants referenced in this function


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 1
	[00000] [00000] [0x0000021]	    ADD                            A=2   B=0   C=1          ; var2 = var0 + var1
	[00001] [00001] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00008] [00012] [0x0000040]	    DUPCLOSURE                     A=1   D=6                ; var1 = static
[00009] [00013] [0x0000010]	    SETTABLEKS [0x0000007]         A=1   B=0   C=213        ; var0.static = var1
[00010] [00015] [0x0000036]	    DUPTABLE                       A=3   D=10               ; var3 = { speed = 16 }
[00011] [00016] [0x0000014]	    NAMECALL [0x0000001]           A=1   B=0   C=249        ; <self>var2 = var1 -> var0.setup -- Next CALL/FB instruction must be a __namecall invoker
[00012] [00018] [0x0000015]	    CALL                           A=1   B=3   C=1          ; var1(var2, var3)
[00013] [00019] [0x000000C]	    GETIMPORT [0x40B00000]         A=1   D=12               ; var1 = print
[00014] [00021] [0x0000004]	    LOADN                          A=4   D=5                ; var4 = 5
[00015] [00022] [0x0000014]	    NAMECALL [0x0000003]           A=2   B=0   C=54         ; <self>var3 = var2 -> var0.run -- Next CALL/FB instruction must be a __namecall invoker
[00016] [00024] [0x0000015]	    CALL                           A=2   B=3   C=0          ; ... = var2(var3, var4)
[00017] [00025] [0x0000015]	    CALL                           A=1   B=0   C=1          ; var1(...)
[00018] [00026] [0x000000C]	    GETIMPORT [0x40B00000]         A=1   D=12               ; var1 = print
[00019] [00028] [0x000000F]	    GETTABLEKS [0x0000007]         A=2   B=0   C=213        ; var2 = var0.static
[00020] [00030] [0x0000004]	    LOADN                          A=3   D=1                ; var3 = 1
[00021] [00031] [0x0000004]	    LOADN                          A=4   D=2                ; var4 = 2
[00022] [00032] [0x0000015]	    CALL                           A=2   B=3   C=0          ; ... = var2(var3, var4)
[00023] [00033] [0x0000015]	    CALL                           A=1   B=0   C=1          ; var1(...)
[00024] [00034] [0x0000016]	    RETURN                         A=0   B=2                ; return var0
