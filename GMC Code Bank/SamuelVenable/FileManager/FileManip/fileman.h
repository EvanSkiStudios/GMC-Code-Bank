#include <string>
#include <vector>
#include <cstddef>

namespace strings {

  std::string string_replace_all(std::string str, std::string substr, std::string nstr);
  std::vector<std::string> string_split(std::string str, char delimiter);
  std::string filename_path(std::string fname);
  std::string filename_name(std::string fname);
  std::string filename_ext(std::string fname);
  std::string filename_normalize(std::string fname);
  std::string filename_remove_slash(std::string dname, bool normalize = false);
  std::string filename_add_slash(std::string dname, bool normalize = false);

} // namespace slashes

namespace fileman {

  std::string get_working_directory_ns();
  bool set_working_directory_ns(std::string dname);
  std::string get_temp_directory_ns();
  std::string get_program_directory_ns();
  std::string get_program_filename_ns();
  std::string get_program_pathname_ns(bool print = true);
  std::string filename_absolute_ns(std::string fname);
  bool file_exists_ns(std::string fname);
  bool file_delete_ns(std::string fname);
  bool file_rename_ns(std::string oldname, std::string newname);
  bool file_copy_ns(std::string fname, std::string newname);
  bool directory_exists_ns(std::string dname);
  bool directory_create_ns(std::string dname);
  bool directory_destroy_ns(std::string dname);
  bool directory_rename_ns(std::string oldname, std::string newname);
  bool directory_copy_ns(std::string dname, std::string newname);
  std::string directory_contents_ns(std::string dname, std::string pattern = "*.*", bool includedirs = true);
  std::string environment_get_variable_ns(std::string name);
  bool environment_set_variable_ns(std::string name, std::string value);

} // namespace fileman