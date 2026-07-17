
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 1 (0x0000001)
# Total functions: 2 (0x0000001)

# Constants [12] (0x000000C)
	[0x0000000] : goto resolve on line 1         : type 6 [0x0000006]
	[0x0000001] : "cloneref"                     : type 3 [0x0000003]
	[0x0000002] : cloneref                       : type 4 [0x0000004]
	[0x0000003] : "game"                         : type 3 [0x0000003]
	[0x0000004] : game                           : type 4 [0x0000004]
	[0x0000005] : "HttpService"                  : type 3 [0x0000003]
	[0x0000006] : "GetService"                   : type 3 [0x0000003]
	[0x0000007] : "print"                        : type 3 [0x0000003]
	[0x0000008] : print                          : type 4 [0x0000004]
	[0x0000009] : "speed"                        : type 3 [0x0000003]
	[0x000000A] : 32                             : type 2 [0x0000002]
	[0x000000B] : { speed = 32 }                 : type 8 [0x0000008]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 4
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
local function resolve(var0, var1) --[[ Line: 1, Id: 0 ]]
	# Constants [4] (0x0000004)
		[0x0000000] : "speed"                        : type 3 [0x0000003]
		[0x0000001] : "name"                         : type 3 [0x0000003]
		[0x0000002] : "unnamed"                      : type 3 [0x0000003]
		[0x0000003] : "enabled"                      : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 0
	[00000] [00000] [0x000001A]	    JUMPIFNOT                      A=0   D=3                ; if not var0 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 1 -> 3
	[00000] [00001] [0x000000F]	    GETTABLEKS [0x0000000]         A=2   B=0   C=204        ; var2 = var0.speed
	[00001] [00003] [0x0000019]	    JUMPIF                         A=2   D=1                ; if var2 then goto [B3] else goto [B2]

	# BLOCK 2 (B2) | PC 4 -> 4
	[00000] [00004] [0x0000004]	    LOADN                          A=2   D=16               ; var2 = 16

	# BLOCK 3 (B3) | PC 5 -> 5
	[00000] [00005] [0x000001A]	    JUMPIFNOT                      A=0   D=3                ; if not var0 then goto [B4] else goto [B5]

	# BLOCK 4 (B4) | PC 6 -> 8
	[00000] [00006] [0x000000F]	    GETTABLEKS [0x0000001]         A=3   B=0   C=90         ; var3 = var0.name
	[00001] [00008] [0x0000019]	    JUMPIF                         A=3   D=1                ; if var3 then goto [B6] else goto [B5]

	# BLOCK 5 (B5) | PC 9 -> 9
	[00000] [00009] [0x0000005]	    LOADK                          A=3   D=2                ; var3 = "unnamed"

	# BLOCK 6 (B6) | PC 10 -> 11
	[00000] [00010] [0x0000003]	    LOADB                          A=4   B=0   C=0          ; var4 = false
	[00001] [00011] [0x000004D]	    JUMPXEQKNIL [0x0000000]        A=0   D=7                ; if var0 == nil then goto [B7] else goto [B8]

	# BLOCK 7 (B7) | PC 13 -> 15
	[00000] [00013] [0x000000F]	    GETTABLEKS [0x0000003]         A=5   B=0   C=144        ; var5 = var0.enabled
	[00001] [00015] [0x000004E]	    JUMPXEQKB [0x80000000]         A=5   D=2                ; if var5 ~= false then goto [B10] else goto [B9]

	# BLOCK 9 (B9) | PC 17 -> 17
	[00000] [00017] [0x0000003]	    LOADB                          A=4   B=0   C=1          ; var4 = false ; goto [B8]

	# BLOCK 10 (B10) | PC 18 -> 18
	[00000] [00018] [0x0000003]	    LOADB                          A=4   B=1   C=0          ; var4 = true

	# BLOCK 8 (B8) | PC 19 -> 22
	[00000] [00019] [0x0000006]	    MOVE                           A=5   B=2                ; var5 = var2
	[00001] [00020] [0x0000006]	    MOVE                           A=6   B=3                ; var6 = var3
	[00002] [00021] [0x000002E]	    OR                             A=7   B=4   C=1          ; var7 = var4 or var1
	[00003] [00022] [0x0000016]	    RETURN                         A=5   B=4                ; return var5, var6, var7

end
[00001] [00001] [0x0000040]	    DUPCLOSURE                     A=0   D=0                ; var0 = resolve
[00002] [00002] [0x000000C]	    GETIMPORT [0x40100000]         A=2   D=2                ; var2 = cloneref
[00003] [00004] [0x000001A]	    JUMPIFNOT                      A=2   D=10               ; if not var2 then goto [B1] else goto [B2]

# BLOCK 1 (B1) | PC 5 -> 14
[00000] [00005] [0x000000C]	    GETIMPORT [0x40100000]         A=1   D=2                ; var1 = cloneref
[00001] [00007] [0x000000C]	    GETIMPORT [0x40300000]         A=2   D=4                ; var2 = game
[00002] [00009] [0x0000005]	    LOADK                          A=4   D=5                ; var4 = "HttpService"
[00003] [00010] [0x0000014]	    NAMECALL [0x0000006]           A=2   B=2   C=22         ; <self>var3 = var2 -> var2.GetService -- Next CALL/FB instruction must be a __namecall invoker
[00004] [00012] [0x0000015]	    CALL                           A=2   B=3   C=0          ; ... = var2(var3, var4)
[00005] [00013] [0x0000015]	    CALL                           A=1   B=0   C=2          ; var1 = var1(...)
[00006] [00014] [0x0000019]	    JUMPIF                         A=1   D=6                ; if var1 then goto [B3] else goto [B2]

# BLOCK 2 (B2) | PC 15 -> 20
[00000] [00015] [0x000000C]	    GETIMPORT [0x40300000]         A=1   D=4                ; var1 = game
[00001] [00017] [0x0000005]	    LOADK                          A=3   D=5                ; var3 = "HttpService"
[00002] [00018] [0x0000014]	    NAMECALL [0x0000006]           A=1   B=1   C=22         ; <self>var2 = var1 -> var1.GetService -- Next CALL/FB instruction must be a __namecall invoker
[00003] [00020] [0x0000015]	    CALL                           A=1   B=3   C=2          ; var1 = var1(var2, var3)

# BLOCK 3 (B3) | PC 21 -> 32
[00000] [00021] [0x000000C]	    GETIMPORT [0x40700000]         A=2   D=8                ; var2 = print
[00001] [00023] [0x0000006]	    MOVE                           A=3   B=0                ; var3 = var0
[00002] [00024] [0x0000036]	    DUPTABLE                       A=4   D=11               ; var4 = { speed = 32 }
[00003] [00025] [0x0000003]	    LOADB                          A=5   B=0   C=0          ; var5 = false
[00004] [00026] [0x0000015]	    CALL                           A=3   B=3   C=0          ; ... = var3(var4, var5)
[00005] [00027] [0x0000015]	    CALL                           A=2   B=0   C=1          ; var2(...)
[00006] [00028] [0x000000C]	    GETIMPORT [0x40700000]         A=2   D=8                ; var2 = print
[00007] [00030] [0x0000006]	    MOVE                           A=3   B=1                ; var3 = var1
[00008] [00031] [0x0000015]	    CALL                           A=2   B=2   C=1          ; var2(var3)
[00009] [00032] [0x0000016]	    RETURN                         A=0   B=1                ; return
