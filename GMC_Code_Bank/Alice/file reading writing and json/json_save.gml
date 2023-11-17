
/// @function json_save(filename,value)
/// @description Saves a given GML value (struct/array/string/real) into a JSON file.
/// @param {string} filename        The path of the JSON file to save.
/// @param {any} value                The value to save as a JSON file.
function json_save(_filename, _value) {
    var _json_content = json_stringify(_value);
    file_write_all_text(_filename, _json_content);
}