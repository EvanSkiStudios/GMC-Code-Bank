// check if struct child or variable exists
function struct_child_exists(struct, name) {
    return (variable_struct_exists(struct, name) ||
    is_struct(struct[$ name])) ? true : false;
}