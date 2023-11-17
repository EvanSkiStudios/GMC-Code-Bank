///    @arg    {real}        id        The list to add to
///    @arg    {real}        map        The map to add
/*
*    Put a map into a list properly; JSON compliant
*    If the containing list is destroyed,
*    this map destroys with it.
*/

var a = argument[0];
var b = argument[1];

ds_list_add(a, b);
ds_list_mark_as_map(a, ds_list_size(a)-1);