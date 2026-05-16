# LunaUX-Decompiler [![Version](https://img.shields.io/badge/Version-Beta_1.3-8A2BE2.svg)](https://github.com/boydev-1444/lunaux-decompiler/releases/tag/lastest) [![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
<p align="center"> <img src="https://cdn.discordapp.com/attachments/1365953466622804020/1505053498553663698/Banner.png?ex=6a0939cc&is=6a07e84c&hm=fc7b30959a664c64f0a82c162678b5b8029de9c9ee1f3239cbc34cd328c624e5&" width=1000 > </p>

## > Discord server [here](discord.gg/2mJUD4XDDT)

- A decompiler & disassembler for [Luau](https://luau.org) (Roblox's Lua-based language). This project consists of an algorithm that takes raw Luau bytecode and attempts to reconstruct it into readable Luau source code or low level disassembly.

- Inspirated on Konstant, Oracle and medal, this decompiler was created to bring free decompilation service as medal or other decompilers.


> **Disclaimer:** LunaUX is still in beta, it is not 100% perfect. This decompiler will receive regular updates to fix all those bugs. 

# Installing

<p align="center"> <img src="./Assets/Console.gif" width="800" /> </p>

- ## Windows

```shell
git clone https://github.com/boydev-1444/lunaux-decompiler.git
cd lunaux-decompiler
run.bat
```

- ## Linux

```bash
git clone https://github.com/boydev-1444/lunaux-decompiler.git 
cd lunaux-decompiler 
chmod +x run.sh 
./run.sh
```

- ## CLI Application

- Tool for fast analysis or other
  - Supports base64 encoded inputs or raw bytecodes

```shell
Options:
  -h, --help       Show this help message
  -v, --version    Show version information
  -ih, --hash      Show the current installer hash

Commands:
  run
    Start the LunaUX-Decompiler local server.

  * These commands support raw bytecode or Base64-encoded bytecode

  decomp, decompile <input_file> [output_directory]
      Decompile the specified bytecode file.
      If an output directory is provided, the result will be saved there;
      otherwise, it will be printed to the console.

  disasm, disassemble <input_file> [output_directory]
      Disassemble the specified bytecode file.
      If an output directory is provided, the result will be saved there;
      otherwise, it will be printed to the console.
```