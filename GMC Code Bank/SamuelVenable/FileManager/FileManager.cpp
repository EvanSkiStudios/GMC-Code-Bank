#include "FileManip/fileman.h"

using std::string;

#ifdef _WIN32
#define EXPORTED_FUNCTION extern "C" __declspec(dllexport)
#else /* macOS, Linux, and BSD */
#define EXPORTED_FUNCTION extern "C" __attribute__((visibility("default")))
#endif

EXPORTED_FUNCTION char *get_working_directory() {
  static string result;
  result = fileman::get_working_directory();
  return (char *)result.c_str();
}

EXPORTED_FUNCTION double set_working_directory(char *dname) {
  return fileman::set_working_directory(dname);
}

EXPORTED_FUNCTION char *get_temp_directory() {
  static string result;
  result = fileman::get_temp_directory();
  return (char *)result.c_str();
}

EXPORTED_FUNCTION char *get_program_directory() {
  static string result;
  result = fileman::get_program_directory();
  return (char *)result.c_str();
}

EXPORTED_FUNCTION char *get_program_filename() {
  static string result;
  result = fileman::get_program_filename();
  return (char *)result.c_str();
}

EXPORTED_FUNCTION char *get_program_pathname() {
  static string result;
  result = fileman::get_program_pathname();
  return (char *)result.c_str();
}

EXPORTED_FUNCTION char *filename_absolute(char *fname) {
  static string result;
  result = fileman::filename_absolute(fname);
  return (char *)result.c_str();
}

EXPORTED_FUNCTION double file_exists(char *fname) {
  return fileman::file_exists(fname);
}

EXPORTED_FUNCTION double file_delete(char *fname) {
  return fileman::file_delete(fname);
}

EXPORTED_FUNCTION double file_rename(char *oldname, char *newname) {
  return fileman::file_rename(oldname, newname);
}

EXPORTED_FUNCTION double file_copy(char *fname, char *newname) {
  return fileman::file_copy(fname, newname);
}

EXPORTED_FUNCTION double file_size(char *fname) {
  return fileman::file_size(fname);
}

EXPORTED_FUNCTION double directory_exists(char *dname) {
  return fileman::directory_exists(dname);
}

EXPORTED_FUNCTION double directory_create(char *dname) {
  return fileman::directory_create(dname);
}

EXPORTED_FUNCTION double directory_destroy(char *dname) {
  return fileman::directory_destroy(dname);
}

EXPORTED_FUNCTION double directory_rename(char *oldname, char *newname) {
  return fileman::directory_rename(oldname, newname);
}

EXPORTED_FUNCTION double directory_copy(char *dname, char *newname) {
  return fileman::directory_copy(dname, newname);
}

EXPORTED_FUNCTION double directory_size(char *dname) {
  return fileman::directory_size(dname);
}

EXPORTED_FUNCTION char *directory_contents(char *dname) {
  static string result;
  result = fileman::directory_contents(dname);
  return (char *)result.c_str();
}

EXPORTED_FUNCTION char *directory_contents_ext(char *dname, char *pattern, double includedirs) {
  static string result;
  result = fileman::directory_contents(dname, pattern, includedirs);
  return (char *)result.c_str();
}

EXPORTED_FUNCTION char *environment_get_variable(char *name) {
  static string result;
  result = fileman::environment_get_variable(name);
  return (char *)result.c_str();
}

EXPORTED_FUNCTION double environment_set_variable(char *name, char *value) {
  return fileman::environment_set_variable(name, value);
}