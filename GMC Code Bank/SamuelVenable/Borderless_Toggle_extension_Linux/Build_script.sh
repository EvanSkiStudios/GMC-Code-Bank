cd "${0%/*}"
g++ -c -std=c++17 "ShowBorder.cpp" -fPIC -m64
g++ "ShowBorder.o" -o "ShowBorder.so" -shared -fPIC -m64