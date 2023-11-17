// get and remove this variable from struct
function struct_pop(struct, name) {
    var _value = struct[$ name];
    variable_struct_remove(struct, name);
    return _value;
}