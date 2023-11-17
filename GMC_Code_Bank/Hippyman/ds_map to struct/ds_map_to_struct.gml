/// @func ds_map_to_struct
function ds_map_to_struct(map) {
    var struct = {};
    var key = ds_map_find_first(map);
    var count = ds_map_size(map);
    for (var i = 0; i < count; ++i) {
       
        if (ds_map_is_map(map,key)) {
            // Value is a ds_map
            variable_struct_set(struct,key,ds_map_to_struct(map[? key ]));
        } else if (ds_map_is_list(map,key)) {
            // Value is a ds_list
            variable_struct_set(struct,key,ds_list_to_array(map[? key ]));
        } else {
            // Value is a real/string/boolean
            variable_struct_set(struct,key,map[? key ]);
        }
       
        key = ds_map_find_next(map,key);
    }
   
    return struct;
}