/// @desc Combines structs together
/// @param {array} array of structs to combine
/// @return {struct} Combined struct
function struct_combine(structs){
    var output_struct = {};
    var struct_array_len = array_length(structs);
    for(var i = 0; i <= struct_array_len-1; ++i){
        var struct_value_name_array = struct_get_names(structs[i]);
        var len = array_length(struct_value_name_array);
        for (var j = 0; j <= len-1; ++j){
            var struct_value_values = variable_struct_get(structs[i],struct_value_name_array[j]);
            struct_set(output_struct, structs[i], struct_value_values);
        }
    }
    return output_struct;
}