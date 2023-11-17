// clear all variables and replace with new struct data
function struct_replace(src, dest) {
    if is_struct(src) && is_struct(dest) {
        struct_clear(dest);
        struct_copy(src, dest);
        return true;
    }
    return -1;
}