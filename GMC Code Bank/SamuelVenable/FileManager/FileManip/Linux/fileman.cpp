#include "../fileman.h"
#include <iostream>
#include <cstdlib>

using std::string;
using std::cout;
using std::endl;

namespace fileman {

  string get_program_pathname_ns(bool print) {
    string path;
    char *buffer = realpath("/proc/self/exe", NULL);
    path = buffer ? : "";
    free(buffer);
    if (!path.empty()) {
      if (print) {
        cout << "program_pathname = \"" << path << "\"" << endl;
      }
    }
    return path;
  }

} // namespace fileman