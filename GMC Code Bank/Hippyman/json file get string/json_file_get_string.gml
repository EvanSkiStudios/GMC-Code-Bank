/// @func json_file_get_string
function json_file_get_string(path) {
    if (!file_exists(path)) show_error(path + " doesn't exist. Check the path.",true);
    var file = file_text_open_read(path);
    var json_string = ""
    while (!file_text_eof(file)) {
        json_string += file_text_readln(file);
    }
    file_text_close(file);
    return json_string;
}