# XGetDisplay

XGetDisplay - Print Primary Monitor WidthxHeight+X+Y with X11

This application takes no additional arguments - easy to use!

Statically links all dependencies except -ldl for convenience

If you get build errors you will need to install dependencies

In order to build, you will need these dependencies (Debian/Ubuntu-based Linux example):

```
sudo apt-get install git dpkg-dev:amd64 cpp:amd64 binutils:amd64 g++-7:amd64 gcc-7:amd64 g++:amd64 gcc:amd64 g++-multilib:amd64 gcc-multilib:amd64 make:amd64 libstdc++6:amd64 libgcc-8-dev:amd64 libxinerama-dev:amd64 libxrandr-dev:amd64 libxext-dev:amd64 libxrender-dev:amd64 libx11-dev:amd64 libc6-dev:amd64
```

Build for amd64 Linux and BSD with:
```
cd "${0%/*}"
git clone git://github.molgen.mpg.de/git-mirror/glibc.git
./glibc/configure --enable-static-nss
gcc -no-pie XDisplayGetters.c ExampleUsage.c -Wl,-Bstatic -static-libstdc++ -static-libgcc -lXinerama -lXrandr -lXext -lXrender -lX11 -lxcb -lXau -lXdmcp -Wl,-Bdynamic -ldl -m64 -o xgetdisplay-c-amd64 -fPIC -m64
```

Build for x86_64 Mac via XQuartz with:
```
cd "${0%/*}"
clang XDisplayGetters.c ExampleUsage.c -lXinerama -lXrandr -lXext -lXrender -lX11 -lxcb -lXau -lXdmcp -ldl -m64 -o xgetdisplay-c-x86_64 -L/usr/X11/lib -I/usr/X11/include -fPIC -m64
```

View it on [GitHub](https://github.com/time-killer-games/XGetDisplay-ForLinuxAndBSD) for a C++ example instead of C as well as support for more architectures and downloadable Linux binaries.

Note the prebuilt binaries can be used with my [EvaluateShell](https://marketplace.yoyogames.com/assets/8457/evaluate-shell) extension to return and parse the output printing for use in GM.