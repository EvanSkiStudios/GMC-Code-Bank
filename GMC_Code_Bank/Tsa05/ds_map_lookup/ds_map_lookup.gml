/// @description ds_map_lookup(map, key, default);
///    @arg    {ds_map}        map        The Map to search
///    @arg    {real,string}    key        The key to look up
///    @arg    {real,string}    default The value to return if not found
var m = argument[0];
var k = argument[1];
var d = argument[2];
if(!is_undefined(m) && ds_exists(real(m), ds_type_map) && ds_map_exists(m,k)){
    d = ds_map_find_value(m,k);
}
return d;