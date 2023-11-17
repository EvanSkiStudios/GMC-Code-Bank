Transitioning to C++17 with my FileManager Extension. Here's the re-write's source code:

Build Scripts

"Win32 (x86).sh"
```
cd "${0%/*}"
mkdir "FileManager (x86)"
g++ FileManip/Win32/fileman.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x86)/FileManager.dll" -std=c++17 -shared -static-libgcc -static-libstdc++ -static -lshell32 -m32
```
"Win32 (x64).sh"

```
cd "${0%/*}"
mkdir "FileManager (x64)"
g++ FileManip/Win32/fileman.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x64)/FileManager.dll" -std=c++17 -shared -static-libgcc -static-libstdc++ -static -lshell32 -m64
```

"MacOSX (x86).sh"
```
cd "${0%/*}"
mkdir "FileManager (x86)"
clang++ FileManip/MacOSX/fileman.cpp FileManip/POSIX/fileman.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x86)/FileManager.dylib" -std=c++17 -shared -m32 -fPIC
```

"MacOSX (x64).sh"
```
cd "${0%/*}"
mkdir "FileManager (x64)"
clang++ FileManip/MacOSX/fileman.cpp FileManip/POSIX/fileman.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x64)/FileManager.dylib" -std=c++17 -shared -m64 -fPIC
```

"Linux (x86).sh"
```
cd "${0%/*}"
mkdir "FileManager (x86)"
g++ FileManip/Linux/fileman.cpp FileManip/POSIX/fileman.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x86)/FileManager.so" -std=c++17 -shared -static-libgcc -static-libstdc++ -m32 -fPIC
```

"Linux (x64).sh"
```
cd "${0%/*}"
mkdir "FileManager (x64)"
g++ FileManip/Linux/fileman.cpp FileManip/POSIX/fileman.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x64)/FileManager.so" -std=c++17 -shared -static-libgcc -static-libstdc++ -m64 -fPIC
```

"BSD (x86).sh"
```
cd "${0%/*}"
mkdir "FileManager (x86)"
g++ FileManip/BSD/fileman.cpp FileManip/POSIX/fileman.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x86)/FileManager.so" -std=c++17 -shared -static-libgcc -static-libstdc++ -m32 -fPIC
```

"BSD (x64).sh"
```
cd "${0%/*}"
mkdir "FileManager (x64)"
g++ FileManip/BSD/fileman.cpp FileManip/POSIX/fileman.cpp FileManip.cpp FileManip/Universal/fileman.cpp FileManip.cpp -o "FileManager (x64)/FileManager.so" -std=c++17 -shared -static-libgcc -static-libstdc++ -m64 -fPIC
```

The extension's prebuilt binaries and gmx/yyp demo projects can be downloaded here: https://drive.google.com/drive/folders/1nx62yTl3BUGXgCYhnFDjoMo3Yw5GGRPZ


Wanted to give the update that my previous post directly above has been edited to support recursive folder creation with all functions. Meaning, as for one example, you may copy a file or directory to a destination path that doesn't even exist yet, and it will recursively create directories automatically until the destination path exists, then it will actually copy the file or directory inside that specified path. It will also now print to the debug console the exact file operations being attempted, displaying each file or directory used in the operation as an absolute path. And lastly, I fixed yet another bug I found with attempting to copy a directory inside itself. Next I am going to replace the exceptions with the proper failure case checks.