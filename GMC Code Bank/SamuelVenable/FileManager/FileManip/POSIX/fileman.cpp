#include "../fileman.h"
#include <unistd.h>
#include <cstdlib>

using std::string;

namespace strings {

  string filename_normalize(string fname) {
    bool has_slash = false;
    while (fname.back() == '/') {
      has_slash = true;
      fname.pop_back();
    }
    char *buffer = realpath(fname.c_str(), NULL);
    if (buffer) {
      fname = buffer;
      free(buffer);
    } else {
      string name = filename_name(fname);
      fname = filename_path(fname);
      char *buffer = realpath(fname.c_str(), NULL);
      if (buffer) {
        fname = buffer;
        free(buffer);
        if (fname.back() != '/') fname += "/";
        fname += name;
      } else {
        return filename_normalize(fname);
      }
    }
    if (has_slash && fname.back() != '/')
      fname += "/";
    return fname;
  }

  string filename_remove_slash(string dname, bool normalize) {
    if (normalize) dname = filename_normalize(dname);
    if (dname.back() == '/') dname.pop_back();
    return dname;
  }

  string filename_add_slash(string dname, bool normalize) {
    if (normalize) dname = filename_normalize(dname);
    if (dname.back() != '/') dname += "/";
    return dname;
  }

} // namespace strings

namespace fileman {

  bool set_working_directory_ns(string dname) {
    return (chdir(strings::filename_remove_slash(filename_absolute_ns(dname)).c_str()) == 0);
  }

  string environment_get_variable_ns(string name) {
    char *value = getenv(name.c_str());
    return value ? value : "";
  }

  bool environment_set_variable_ns(string name, string value) {
    if (value == "") return (unsetenv(name.c_str()) == 0);
    return (setenv(name.c_str(), value.c_str(), 1) == 0);
  }

} // namespace fileman