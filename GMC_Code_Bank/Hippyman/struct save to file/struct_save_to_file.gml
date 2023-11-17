function struct_save_to_file(struct,path) {
    var json_string = struct_get_string(struct);
    var file = file_text_open_write(path);
    file_text_write_string(file,json_string);
    file_text_close(file);
}