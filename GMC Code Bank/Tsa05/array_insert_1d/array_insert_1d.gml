///    @description    Returns the modified array
///    @arg    {real}    array    The arrey to insert into
///    @arg    {real}    index    Where to insert
///    @arg            value    What to add to the array
///    @returns    {real}    Array with the newly inserted value

var a = argument[0];
var p = argument[1];
var d = argument[2];

if(!is_array(a)){
    a[0] = d;
}else{
    var L = array_length_1d(a);
    var r = array_create(1);
    array_copy(r, 0, a, 0, p);
    r[p] = d;
    array_copy(r, p+1, a, p, L-p+1);
}
return r;