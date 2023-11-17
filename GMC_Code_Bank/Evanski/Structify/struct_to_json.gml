/// @desc Converts a Struct to a Json file
/// @param {struct} struct_index Index of the struct to use
/// @param {string} json_name Name of Json file to create
/// @return {real} 0 if success, or -1 if it fails
function struct_to_json(struct_index,json_name){
    if file_exists(json_name) file_delete(json_name);
    var json_string = json_stringify(struct_index);
    var buffer = buffer_create(string_byte_length(json_string)+1, buffer_fixed, 1);
    var output = buffer_write(buffer, buffer_text, json_string);
    buffer_save(buffer,string(json_name));
    buffer_delete(buffer);
    return output;
}