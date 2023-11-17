///    @description    array_find(array, value)
///    @args    {array}    array    The array to search
///    @args    {any}    value    The value to search for
/*
*    Searches a given array for the value indicated.
*    Returns -1 or the first index located.
*/
var a = argument[0];
var v = argument[1];
var retval = -1;
if(!is_array(a)){
    return retval;
}
var type = typeof(v)
for(var z=0;z<array_length_1d(a);z+=1){
    var av = a[z];
    var avtype = typeof(av);
    if(avtype==type){
        if(av==v){
            retval = z;
            return retval;
        }
    }
}
return retval;