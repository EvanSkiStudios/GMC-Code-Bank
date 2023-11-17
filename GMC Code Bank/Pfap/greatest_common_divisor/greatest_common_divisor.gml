// gcd(a,b)
// constraint: a>0 and b>0
var a,b;
a = argument0;
b = argument1;
//It will run until the return. while true == true{
while true {
    a = a % b;
    if a = 0{ return b };
    b = b % a;
    if b = 0{ return a };
}