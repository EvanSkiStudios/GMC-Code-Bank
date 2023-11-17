function array_get_string(array) {
    var array_str = "[";
    var count = array_length(array);
    for (var i = 0; i < count; ++i) {
        var val = array[i];
        if (is_struct(val)) {
            val = struct_get_string(val);
        } else if (is_array(val)) {
            val = array_get_string(val);
        } else if (is_string(val)) {
            val = "\"" + val + "\"";
        } else {
            val = string(val);
        }
        
        array_str += val;
        if (i < count-1) {
            array_str += ",";
        }
    }
    
    array_str += "]";
    
    return array_str;
}