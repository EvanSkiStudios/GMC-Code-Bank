function struct_get_string(struct) {
    var struct_str = "{";
    var var_count = variable_struct_names_count(struct);
    var var_names = variable_struct_get_names(struct)
    for (var i = 0; i < var_count; ++i) {
        var var_name = var_names[i];
        var var_val = variable_struct_get(struct,var_name);
        if (is_struct(var_val)) {
            var_val = struct_get_string(var_val);
        } else if (is_array(var_val)) {
            var_val = array_get_string(var_val);
        } else if (is_string(var_val)) {
            var_val = "\"" + var_val + "\"";
        } else {
            var_val = string(var_val);
        }
        
        struct_str += "\"" + var_name + "\"" + ":" + var_val;
        if (i < var_count-1) {
            struct_str += ",";
        }
    }
    
    struct_str += "}";
    
    return struct_str;
}