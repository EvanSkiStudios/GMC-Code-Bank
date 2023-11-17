///    @description        Returns whether a value is in the supplied set of arguments
///    @function            is_in( value, test0, [test1], [...] )
///    @param                value    The value to search for
///    @param                test0    Value to compare to
///    @param                [test1]    Add parameters as needed to extend the set
///    @returns    {bool}    True when value was found in set
/*
*    Suppose we want to test whether x, y, or z is equal to value.
*    GameMaker:
*        if(x==value || y==value || z==value)
*    Python:
*        if value in {x, y, z}
*    This script shortens what you'd have to type in GameMaker like so:
*        if is_in(value, x, y, z)
*/
// Created for SLIDGE engine
// Submitted to GMLscripts.com/license

var test = argument[0];
var argz = 0;
for(var z=1; z<argument_count; z+=1){
    argz = argument[z];
    if(is_array(argz)){
        for(var i=0; i<array_length_1d(argz); i+=1){
            if(test == argz[i]){
                return true;
            }
        }
    }else{
        if(test == argument[z]){
            return true;
        }
    }
}
return false;