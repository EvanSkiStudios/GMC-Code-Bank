///tsprintf(format,...)
//Trivial String Print Format
//Replaces each % percent sign with an argument, then returns the string.
//Inteded to make writing debug printouts less painful.
var c;
for(c = 1;c < argument_count;c++){
    argument[0] = string_replace(argument[0],"%",string(argument[c]));
}
return argument[0];