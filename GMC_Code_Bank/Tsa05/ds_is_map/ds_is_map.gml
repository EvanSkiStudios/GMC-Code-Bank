///@description    ds_is_map(mapID)
///@param    mapID    Check whether this is a map
/*
*    Returns whether the input is a map
*/
var m = argument[0];

return !(is_undefined(m) || is_string(m) || !ds_exists(m,ds_type_map));