/// @desc Converts a Json file to a Struct
/// @param {string} json The Json file to load.
/// @return {any} struct or -1 on fail
function json_to_struct(json){
    if !(file_exists(json)) return(-1);
    var file = buffer_load(json);
    var json_string = buffer_read(file, buffer_text);
    buffer_delete(file);
    return (json_parse(json_string));
}