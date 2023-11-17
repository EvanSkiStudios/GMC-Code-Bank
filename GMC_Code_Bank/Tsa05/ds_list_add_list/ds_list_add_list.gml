///    @arg    {real}        id        The list to add to
///    @arg    {real}        list    The list to add
/*
*    Put a list into a list properly; JSON compliant
*    If the containing list is destroyed,
*    this list destroys with it.
*
*/
var a = argument[0];
var b = argument[1];

ds_list_add(a, b);
ds_list_mark_as_list(a, ds_list_size(a)-1);