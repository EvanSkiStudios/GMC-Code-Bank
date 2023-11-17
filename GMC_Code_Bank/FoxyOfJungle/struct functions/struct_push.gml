// add variable to struct
function struct_push(struct, name, value) {
    var _num = 0;
    if variable_struct_exists(struct, name) {
        while (variable_struct_exists(struct, name+string(_num))) {
            _num += 1;
        }
    } else {
        _num = "";
    }
    struct[$ name+string(_num)] = value;
}