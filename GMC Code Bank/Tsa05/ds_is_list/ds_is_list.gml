///@description    ds_is_list(listID)
///@param    listID    Check whether this is a list
var l = argument[0];

return !(is_undefined(l) || is_string(l) || !ds_exists(l,ds_type_list));