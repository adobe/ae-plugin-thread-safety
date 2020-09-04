This tool finds problematic global symbols in your effect code by examining the programming database (.pdb) file output by debug builds of your plugin. It filters these symbols by either source file or compiland, which can be specified using the -source flag or the -objfile flag. All paths must be absolute and case-insensitive.

Installation:
In order to run this tool, you need a working installation of Visual Studio and you need to have the DIA SDK registered. Included is register_msdia.cmd, which will register the SDK for you.

From the Start menu, search for "x64 Native Tools Command Prompt for VS 2017" and Right Click->Run as administrator.

In the terminal, cd to this directory and run .\register_msdia.cmd

After this, the script should just work, e.g.:
.\CheckThreadSafeIssues.exe -sf [Path to your project pdb]

Alternatively, if you know where msdia.dll is on your system you can register it manually with regsvr32 <full path to dll>

For instructions on how to use the tool and understand the output, see the AfterEffects Plugin SDK docs at http://ae-plugin-sdk.aenhancers.com/effect-details/multi-frame-rendering-in-ae.html
