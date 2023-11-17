/// @func json_load_from_file
function json_load_from_file(path) {
    var json_string = json_file_get_string(path);
    var json_map = json_decode(json_string);
    var json_object = ds_map_to_struct(json_map);
    ds_map_destroy(json_map);
    return json_object;
}