/// @description ds_map_lookup(list, index, default);
///    @arg    {ds_list}        list        The Map to search
///    @arg    {real}            index        The key to look up
///    @arg                    default        The value to return if not found
var L = argument[0];
var k = argument[1];
var d = argument[2];
if(!is_undefined(L) && ds_exists(real(L), ds_type_list) && k>=0 && k<ds_list_size(L)){
    d = L[|k];
}
return d;