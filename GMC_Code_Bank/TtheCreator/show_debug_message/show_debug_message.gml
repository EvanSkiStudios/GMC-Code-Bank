///sdbm(var1,var2)

/*
Stands for "show debug message" and writes a log line showing any values given to it.(Will be shown within game maker's compiler log)
Multiple arguments of any type can be passes to this script and every argument will be seperated by a "#" symbol.
*/

var str=""
for(var i=0;i<argument_count;i++){
str=str+string(argument[i])+"#"
}
show_debug_message(str)