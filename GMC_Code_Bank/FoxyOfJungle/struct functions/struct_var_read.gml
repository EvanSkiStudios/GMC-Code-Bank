// get value from json without returning undefined (useful for savegames data loading)
function struct_var_read(struct, name, default_var) {
    var _df = default_var;
    if variable_struct_exists(struct, name) {
        var _val = struct[$ name];
        if !is_undefined(_val) {
            return _val;
        }
    }
    return _df;
}