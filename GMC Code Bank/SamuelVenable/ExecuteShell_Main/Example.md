evaluates shell scripts, while similar to my "famous" Execute Shell extension, not only can it execute from the shell, it can also read any output from it (not including errors, but that could easily be added with a small tweak). Compile it with the G++ GNU C++ Compiler, using the following in any Unix terminal:  

```
cd /Path/To/EvaluateShell/
g++ -c -std=c++11 main.cpp -fPIC -m64
g++ main.o -o EvaluateShell.x64/EvaluateShell.so -shared -fPIC -m64
```

Replace "/Path/To/EvaluateShell/" with the path to a folder containing the C++ code file and make sure that file is named "main.cpp". You will need an output folder in that same directory named "EvaluateShell.x64". Notice the x64, this will be for 64-bit builds and requires building on a 64-bit Unix OS (whether macOS, Linux, BSD, Solaris, or whatever).

If you want 32-bit support of this extension sample, the same rules apply. Install G++ on your OS as needed, cd to the correct path, and run the commands one line at a time on your terminal application. Create the same folder, but this time have it named "EvaluateShell.x86". Depending on your OS, you will need the proper file extension for the shared library. Linux as you can see is *.so, macOS is *.dylib, Windows is *.dll and so forth:  

```
cd /Path/To/EvaluateShell/
g++ -c -std=c++11 main.cpp -fPIC -m32
g++ main.o -o EvaluateShell.x86/EvaluateShell.dylib -shared -fPIC -m32
```

Notice in the above terminal commands snippet, this time I used the dylib extenson - "EvaluateShell.dylib" - this is good for compiling on macOS right out of the box as soon as you have G++ via the HomeBrew package manager. On Linux you can compile the code in the snippet previous to the one directly above and you can use the extension via GameMaker Studio 1.4, as the Linux runner is 32-bit in all versions of Studio prior to 2.x. Mac is 64-bit in both runners as of 1.49999 to Studio 2.x onward.

Should you compile for Studio 2 on Linux, you will need to use the -m64 flag instead of -m32, via modifying the terminal snippet, depending on which one of the two you copy/paste. Create an extension in Studio from the Extensions node of the resource tree in the IDE. Get the library file imported and create the function. Make sure the internal and external names of the function are "evaluate_shell". The return value must be a string. Add an argument and make it a string. The help line should be:  

```
evaluate_shell(command)
```

Now you are ready to test it. command is the terminal command or shell script contents you wish to execute and evaluate.