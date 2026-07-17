
# Luau version: 9 (0x0000009)
# Types version: 3 (0x0000003)
# Magic key: 1 (0x0000001)
# Main function id: 0 (0x0000000)
# Total functions: 1 (0x0000000)

# Constants [12] (0x000000C)
	[0x0000000] : "game"                         : type 3 [0x0000003]
	[0x0000001] : game                           : type 4 [0x0000004]
	[0x0000002] : "RunService"                   : type 3 [0x0000003]
	[0x0000003] : "GetService"                   : type 3 [0x0000003]
	[0x0000004] : "IsClient"                     : type 3 [0x0000003]
	[0x0000005] : "IsServer"                     : type 3 [0x0000003]
	[0x0000006] : "IsStudio"                     : type 3 [0x0000003]
	[0x0000007] : "require"                      : type 3 [0x0000003]
	[0x0000008] : require                        : type 4 [0x0000004]
	[0x0000009] : "ServerScriptService"          : type 3 [0x0000003]
	[0x000000A] : "print"                        : type 3 [0x0000003]
	[0x000000B] : print                          : type 4 [0x0000004]


# BLOCK 0  [ENTRY] (B0) | PC 0 -> 19
[00000] [00000] [0x0000041]	    PREPVARARGS                    A=0                      ; -- Prepare for any number (top) of variables as ...
[00001] [00001] [0x000000C]	    GETIMPORT [0x40000000]         A=0   D=1                ; var0 = game
[00002] [00003] [0x0000005]	    LOADK                          A=2   D=2                ; var2 = "RunService"
[00003] [00004] [0x0000014]	    NAMECALL [0x0000003]           A=0   B=0   C=22         ; <self>var1 = var0 -> var0.GetService -- Next CALL/FB instruction must be a __namecall invoker
[00004] [00006] [0x0000015]	    CALL                           A=0   B=3   C=2          ; var0 = var0(var1, var2)
[00005] [00007] [0x0000014]	    NAMECALL [0x0000004]           A=1   B=0   C=4          ; <self>var2 = var1 -> var0.IsClient -- Next CALL/FB instruction must be a __namecall invoker
[00006] [00009] [0x0000015]	    CALL                           A=1   B=2   C=2          ; var1 = var1(var2)
[00007] [00010] [0x0000014]	    NAMECALL [0x0000005]           A=2   B=0   C=11         ; <self>var3 = var2 -> var0.IsServer -- Next CALL/FB instruction must be a __namecall invoker
[00008] [00012] [0x0000015]	    CALL                           A=2   B=2   C=2          ; var2 = var2(var3)
[00009] [00013] [0x0000014]	    NAMECALL [0x0000006]           A=3   B=0   C=10         ; <self>var4 = var3 -> var0.IsStudio -- Next CALL/FB instruction must be a __namecall invoker
[00010] [00015] [0x0000015]	    CALL                           A=3   B=2   C=2          ; var3 = var3(var4)
[00011] [00016] [0x0000014]	    NAMECALL [0x0000005]           A=4   B=0   C=11         ; <self>var5 = var4 -> var0.IsServer -- Next CALL/FB instruction must be a __namecall invoker
[00012] [00018] [0x0000015]	    CALL                           A=4   B=2   C=2          ; var4 = var4(var5)
[00013] [00019] [0x000001A]	    JUMPIFNOT                      A=4   D=9                ; if not var4 then goto [B1] else goto [B2]

# BLOCK 1 (B1) | PC 20 -> 28
[00000] [00020] [0x000000C]	    GETIMPORT [0x40700000]         A=4   D=8                ; var4 = require
[00001] [00022] [0x000000C]	    GETIMPORT [0x40000000]         A=5   D=1                ; var5 = game
[00002] [00024] [0x0000005]	    LOADK                          A=7   D=9                ; var7 = "ServerScriptService"
[00003] [00025] [0x0000014]	    NAMECALL [0x0000003]           A=5   B=5   C=22         ; <self>var6 = var5 -> var5.GetService -- Next CALL/FB instruction must be a __namecall invoker
[00004] [00027] [0x0000015]	    CALL                           A=5   B=3   C=0          ; ... = var5(var6, var7)
[00005] [00028] [0x0000015]	    CALL                           A=4   B=0   C=2          ; var4 = var4(...)

# BLOCK 2 (B2) | PC 29 -> 33
[00000] [00029] [0x000000C]	    GETIMPORT [0x40A00000]         A=4   D=11               ; var4 = print
[00001] [00031] [0x0000006]	    MOVE                           A=5   B=3                ; var5 = var3
[00002] [00032] [0x0000015]	    CALL                           A=4   B=2   C=1          ; var4(var5)
[00003] [00033] [0x0000016]	    RETURN                         A=0   B=1                ; return
