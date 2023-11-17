/// @desc string_to_array(string, token)
/// @arg {string} string The string to tokenize
/// @arg {string} token The character to use as a token
/*
*   Turn a tokenized string into an array of values
*/

var s = argument0;
var t = argument1;
var a = 0;

var n = string_count(t,s);
if(string_char_at(s,string_length(s))!=t){
    n+=1;
}

for(var z = 0;z<n;z+=1){
    var p = string_pos(t,s);
    if(!p) p=string_length(s)+1;
    a[z] = string_copy(s,1,p-1);
    s = string_delete(s,1,p-1+string_length(t));
}
return a;