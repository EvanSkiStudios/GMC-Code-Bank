#include "../fileman.h"
#include <libproc.h>
#include <unistd.h>
#include <iostream>

using std::string;
using std::cout;
using std::endl;

namespace fileman {

  string get_program_pathname_ns(bool print) {
    string path;
    char buffer[PROC_PIDPATHINFO_MAXSIZE];
    if (proc_pidpath(getpid(), buffer, sizeof(buffer)) > 0) {
      path = string(buffer) + "\0";
    }
    if (!path.empty()) {
      if (print) {
        cout << "program_pathname = \"" << path << "\"" << endl;
      }
    }
    return path;
  }

} // namespace fileman