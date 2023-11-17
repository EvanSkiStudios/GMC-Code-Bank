///    @description     array_delete(array, pos)
///    @arg    {array}    array    The array to delete from
///    @arg    {real}    pos        The position to delete
///    @returns a new array or -1 when the array is empty
var a = argument0;
var i = argument1;
var r = -1;
var L = array_length_1d(a);
if(L>1){
    r=array_create(L-1);
    array_copy(r, 0, a, 0, i);
    array_copy(r, i, a, i+1, L-i+1);
}
return r;