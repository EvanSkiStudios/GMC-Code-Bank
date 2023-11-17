#include "../fileman.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <iostream>
#include <cstddef>

using std::string;
using std::size_t;
using std::cout;
using std::endl;

namespace fileman {

  string get_program_pathname_ns(bool print) {
    string path;
    size_t length;
    // CTL_KERN::KERN_PROC::KERN_PROC_PATHNAME(-1)
    int mib[4] = { CTL_KERN, KERN_PROC, KERN_PROC_PATHNAME, -1 };
    if (sysctl(mib, 4, NULL, &length, NULL, 0) == 0) {
      path.resize(length, '\0');
      char *buffer = path.data();
      if (sysctl(mib, 4, buffer, &length, NULL, 0) == 0) {
        path = string(buffer) + "\0";
      }
    }
    if (!path.empty()) {
      if (print) {
        cout << "program_pathname = \"" << path << "\"" << endl;
      }
    }
    return path;
  }

} // namespace fileman