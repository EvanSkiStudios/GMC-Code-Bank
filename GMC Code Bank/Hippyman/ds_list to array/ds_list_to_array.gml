/// @func ds_list_to_array
function ds_list_to_array(list) {
    var count = ds_list_size(list);
    var array = array_create(count);
    for (var i = 0; i < count; ++i) {
        //var val = list[| i ];
       
        if (ds_list_is_map(list,i)) {
            // Value is a ds_map
            array[ i ] = ds_map_to_struct(list[| i ]);
        } else if (ds_list_is_list(list,i)) {
            // Value is a ds_list
            array[ i ] = ds_list_to_array(list[| i ]);
        } else {
            // value is a real/string/boolean
            array[ i ] = list[| i ];
        }
    }
    return array;
}