// clear the struct without deleting it
function struct_clear(struct) {
    if is_struct(struct) {
        var _names = variable_struct_get_names(struct);
        var _size = array_length(_names);
 
        for (var i = 0; i < _size; ++i) {
            var _name = _names[i];
            variable_struct_remove(struct, _name);
        }
    }
}