// copy one struct to many others
function struct_multiply(src, dest_array) {
    if is_array(dest_array) {
        var _size = array_length(dest_array);
 
        for (var i = 0; i < _size; ++i) {
            var _dest = dest_array[i];
            struct_copy(src, _dest);
        }
        return true;
    }
    return -1;
}