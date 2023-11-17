// copy all struct variables and values to another
function struct_copy(src, dest) {
    if is_struct(src) {
        if !is_struct(dest) dest = {};
        var _names = variable_struct_get_names(src);
        var _size = array_length(_names);
     
        for (var i = 0; i < _size; ++i) {
            var _name = _names[i];
            variable_struct_set(dest, _name, variable_struct_get(src, _name));
        }
        return true;
    }
    return -1;
}