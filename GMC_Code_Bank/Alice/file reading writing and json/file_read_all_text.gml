/// @function file_read_all_text(filename)
/// @description Reads entire content of a given file as a string, or returns undefined if the file doesn't exist.
/// @param {string} filename        The path of the file to read the content of.
function file_read_all_text(_filename) {
    if (!file_exists(_filename)) {
        return undefined;
    }
    
    var _buffer = buffer_load(_filename);
    var _result = buffer_read(_buffer, buffer_string);
    buffer_delete(_buffer);
    return _result;
}