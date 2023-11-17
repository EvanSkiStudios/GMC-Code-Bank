/// @description array_to_string(array, token)
/// @arg {array}    array    The array to concatenate
/// @arg {string}    token    Character to tokenize with
var a = argument[0];
var t = argument[1];
var r = "";
if(!is_array(a)){ return a; }
for (var z=0; z<array_length_1d(a); z+=1){
    r+=string(a[z])+t;
}
return r;