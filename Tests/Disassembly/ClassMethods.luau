
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 5 (0x0000005)
# Total functions: 6 (0x0000005)

# Constants [14] (0x000000E)
	[0x0000000] : "__index"                      : type 3 [0x0000003]
	[0x0000001] : goto new on line 4             : type 6 [0x0000006]
	[0x0000002] : "new"                          : type 3 [0x0000003]
	[0x0000003] : goto takeDamage on line 11     : type 6 [0x0000006]
	[0x0000004] : "takeDamage"                   : type 3 [0x0000003]
	[0x0000005] : goto die on line 18            : type 6 [0x0000006]
	[0x0000006] : "die"                          : type 3 [0x0000003]
	[0x0000007] : goto isAlive on line 22        : type 6 [0x0000006]
	[0x0000008] : "isAlive"                      : type 3 [0x0000003]
	[0x0000009] : goto clamp on line 27          : type 6 [0x0000006]
	[0x000000A] : "clamp"                        : type 3 [0x0000003]
	[0x000000B] : "goblin"                       : type 3 [0x0000003]
	[0x000000C] : "print"                        : type 3 [0x0000003]
	[0x000000D] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 47
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x0000035]	    NEWTABLE [0x0000000]           A=0   B=4                ; var0 = {}
[00002] [00003] [0x0000010]	    SETTABLEKS [0x0000000]         A=0   B=0   C=110        ; var0.__index = var0
local function new(var0, var1) --[[ Line: 4, Id: 0 ]]
	# Constants [4] (0x0000004)
		[0x0000000] : "setmetatable"                 : type 3 [0x0000003]
		[0x0000001] : setmetatable                   : type 4 [0x0000004]
		[0x0000002] : "name"                         : type 3 [0x0000003]
		[0x0000003] : "health"                       : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 12
	[00000] [00000] [0x0000035]	    NEWTABLE [0x0000000]           A=3   B=2                ; var3 = {}
	[00001] [00002] [0x0000009]	    GETUPVAL                       A=4   B=0                ; var4 = up_0
	[00002] [00003] [0x000004A]	    FASTCALL2 [0x0000004]          A=61  B=3   C=3          ; ... = setmetatable(var3, var4) -- Uses args and results from the CALL instruction located in [00005]. If successful goto >= [00006]
	[00003] [00005] [0x000000C]	    GETIMPORT [0x40000000]         A=2   D=1                ; var2 = setmetatable
	[00004] [00007] [0x0000015]	    CALL                           A=2   B=3   C=2          ; var2 = var2(var3, var4)
	[00005] [00008] [0x0000010]	    SETTABLEKS [0x0000002]         A=0   B=2   C=90         ; var2.name = var0
	[00006] [00010] [0x0000010]	    SETTABLEKS [0x0000003]         A=1   B=2   C=122        ; var2.health = var1
	[00007] [00012] [0x0000016]	    RETURN                         A=2   B=2                ; return var2

end
[00003] [00005] [0x0000040]	    DUPCLOSURE                     A=1   D=1                ; var1 = new
[00004] [00006] [0x0000046]	    CAPTURE                        A=0   B=0                ; up_0 = var0 -- Readable
[00005] [00007] [0x0000010]	    SETTABLEKS [0x0000002]         A=1   B=0   C=239        ; var0.new = var1
local function takeDamage(var0, var1) --[[ Line: 11, Id: 1 ]]
	# Constants [2] (0x0000002)
		[0x0000000] : "health"                       : type 3 [0x0000003]
		[0x0000001] : "die"                          : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 8
	[00000] [00000] [0x000000F]	    GETTABLEKS [0x0000000]         A=3   B=0   C=122        ; var3 = var0.health
	[00001] [00002] [0x0000022]	    SUB                            A=2   B=3   C=1          ; var2 = var3 - var1
	[00002] [00003] [0x0000010]	    SETTABLEKS [0x0000000]         A=2   B=0   C=122        ; var0.health = var2
	[00003] [00005] [0x000000F]	    GETTABLEKS [0x0000000]         A=2   B=0   C=122        ; var2 = var0.health
	[00004] [00007] [0x0000004]	    LOADN                          A=3   D=0                ; var3 = 0
	[00005] [00008] [0x000001F]	    JUMPIFNOTLE [0x0000003]        A=2   D=4                ; if var2 > var3 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 10 -> 12
	[00000] [00010] [0x0000014]	    NAMECALL [0x0000001]           A=2   B=0   C=215        ; <self>var3 = var2 -> var0.die -- Next CALL/FB instruction must be a __namecall invoker
	[00001] [00012] [0x0000015]	    CALL                           A=2   B=2   C=1          ; var2(var3)

	# BLOCK 2 (B2) | PC 13 -> 13
	[00000] [00013] [0x0000016]	    RETURN                         A=0   B=1                ; return

end
[00006] [00009] [0x0000040]	    DUPCLOSURE                     A=1   D=3                ; var1 = takeDamage
[00007] [00010] [0x0000010]	    SETTABLEKS [0x0000004]         A=1   B=0   C=169        ; var0.takeDamage = var1
local function die(var0) --[[ Line: 18, Id: 2 ]]
	# Constants [1] (0x0000001)
		[0x0000000] : "dead"                         : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 3
	[00000] [00000] [0x0000003]	    LOADB                          A=1   B=1   C=0          ; var1 = true
	[00001] [00001] [0x0000010]	    SETTABLEKS [0x0000000]         A=1   B=0   C=111        ; var0.dead = var1
	[00002] [00003] [0x0000016]	    RETURN                         A=0   B=1                ; return

end
[00008] [00012] [0x0000040]	    DUPCLOSURE                     A=1   D=5                ; var1 = die
[00009] [00013] [0x0000010]	    SETTABLEKS [0x0000006]         A=1   B=0   C=215        ; var0.die = var1
local function isAlive(var0) --[[ Line: 22, Id: 3 ]]
	# Constants [2] (0x0000002)
		[0x0000000] : "dead"                         : type 3 [0x0000003]
		[0x0000001] : "health"                       : type 3 [0x0000003]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 3
	[00000] [00000] [0x000000F]	    GETTABLEKS [0x0000000]         A=2   B=0   C=111        ; var2 = var0.dead
	[00001] [00002] [0x0000032]	    NOT                            A=1   B=2                ; var1 = not var2
	[00002] [00003] [0x000001A]	    JUMPIFNOT                      A=1   D=7                ; if not var1 then goto [B1] else goto [B2]

	# BLOCK 1 (B1) | PC 4 -> 7
	[00000] [00004] [0x000000F]	    GETTABLEKS [0x0000001]         A=2   B=0   C=122        ; var2 = var0.health
	[00001] [00006] [0x0000004]	    LOADN                          A=3   D=0                ; var3 = 0
	[00002] [00007] [0x000001D]	    JUMPIFLT [0x0000002]           A=3   D=2                ; if var3 < var2 then goto [B4] else goto [B3]

	# BLOCK 3 (B3) | PC 9 -> 9
	[00000] [00009] [0x0000003]	    LOADB                          A=1   B=0   C=1          ; var1 = false ; goto [B2]

	# BLOCK 4 (B4) | PC 10 -> 10
	[00000] [00010] [0x0000003]	    LOADB                          A=1   B=1   C=0          ; var1 = true

	# BLOCK 2 (B2) | PC 11 -> 11
	[00000] [00011] [0x0000016]	    RETURN                         A=1   B=2                ; return var1

end
[00010] [00015] [0x0000040]	    DUPCLOSURE                     A=1   D=7                ; var1 = isAlive
[00011] [00016] [0x0000010]	    SETTABLEKS [0x0000008]         A=1   B=0   C=161        ; var0.isAlive = var1
[00012] [00018] [0x0000035]	    NEWTABLE [0x0000000]           A=1   B=1                ; var1 = {}
local function clamp(var0, var1, var2) --[[ Line: 27, Id: 4 ]]
	# Constants [5] (0x0000005)
		[0x0000000] : "math"                         : type 3 [0x0000003]
		[0x0000001] : "min"                          : type 3 [0x0000003]
		[0x0000002] : math.min                       : type 4 [0x0000004]
		[0x0000003] : "max"                          : type 3 [0x0000003]
		[0x0000004] : math.max                       : type 4 [0x0000004]


	# BLOCK 0  [ENTRY] (B0) | PC 0 -> 12
	[00000] [00000] [0x0000006]	    MOVE                           A=4   B=1                ; var4 = var1
	[00001] [00001] [0x000004A]	    FASTCALL2 [0x0000000]          A=19  B=2   C=5          ; ... = math.min(var2, var0) -- Uses args and results from the CALL instruction located in [00005]. If successful goto >= [00006]
	[00002] [00003] [0x0000006]	    MOVE                           A=6   B=2                ; var6 = var2
	[00003] [00004] [0x0000006]	    MOVE                           A=7   B=0                ; var7 = var0
	[00004] [00005] [0x000000C]	    GETIMPORT [0x80000400]         A=5   D=2                ; var5 = math.min
	[00005] [00007] [0x0000015]	    CALL                           A=5   B=3   C=0          ; ... = var5(var6, var7)
	[00006] [00008] [0x0000044]	    FASTCALL                       A=18  C=2                ; ... = math.max(...) -- Uses args and results from the CALL instruction located in [00009]. If successful goto [00010]
	[00007] [00009] [0x000000C]	    GETIMPORT [0x80000C00]         A=3   D=4                ; var3 = math.max
	[00008] [00011] [0x0000015]	    CALL                           A=3   B=0   C=0          ; ... = var3(...)
	[00009] [00012] [0x0000016]	    RETURN                         A=3   B=0                ; return ...

end
[00013] [00020] [0x0000040]	    DUPCLOSURE                     A=2   D=9                ; var2 = clamp
[00014] [00021] [0x0000010]	    SETTABLEKS [0x000000A]         A=2   B=1   C=16         ; var1.clamp = var2
[00015] [00023] [0x000000F]	    GETTABLEKS [0x0000002]         A=2   B=0   C=239        ; var2 = var0.new
[00016] [00025] [0x0000005]	    LOADK                          A=3   D=11               ; var3 = "goblin"
[00017] [00026] [0x0000004]	    LOADN                          A=4   D=10               ; var4 = 10
[00018] [00027] [0x0000015]	    CALL                           A=2   B=3   C=2          ; var2 = var2(var3, var4)
[00019] [00028] [0x0000004]	    LOADN                          A=5   D=5                ; var5 = 5
[00020] [00029] [0x0000014]	    NAMECALL [0x0000004]           A=3   B=2   C=169        ; <self>var4 = var3 -> var2.takeDamage -- Next CALL/FB instruction must be a __namecall invoker
[00021] [00031] [0x0000015]	    CALL                           A=3   B=3   C=1          ; var3(var4, var5)
[00022] [00032] [0x000000C]	    GETIMPORT [0x40C00000]         A=3   D=13               ; var3 = print
[00023] [00034] [0x0000014]	    NAMECALL [0x0000008]           A=4   B=2   C=161        ; <self>var5 = var4 -> var2.isAlive -- Next CALL/FB instruction must be a __namecall invoker
[00024] [00036] [0x0000015]	    CALL                           A=4   B=2   C=0          ; ... = var4(var5)
[00025] [00037] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00026] [00038] [0x000000C]	    GETIMPORT [0x40C00000]         A=3   D=13               ; var3 = print
[00027] [00040] [0x000000F]	    GETTABLEKS [0x000000A]         A=4   B=1   C=16         ; var4 = var1.clamp
[00028] [00042] [0x0000004]	    LOADN                          A=5   D=5                ; var5 = 5
[00029] [00043] [0x0000004]	    LOADN                          A=6   D=0                ; var6 = 0
[00030] [00044] [0x0000004]	    LOADN                          A=7   D=3                ; var7 = 3
[00031] [00045] [0x0000015]	    CALL                           A=4   B=4   C=0          ; ... = var4(var5, var6, var7)
[00032] [00046] [0x0000015]	    CALL                           A=3   B=0   C=1          ; var3(...)
[00033] [00047] [0x0000016]	    RETURN                         A=0   B=2                ; return var0
