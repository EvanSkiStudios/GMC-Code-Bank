/// @description cubic_solve(a, b, c, d)
/// @param a
/// @param b
/// @param c
/// @param d
/*
    Finds the roots of polynomials up to third degree. Returns the result as an array of the following format:
    [x1 real, x1 imaginary, x2 real, x2 imaginary, x3 real, x3 imaginary]
    If a root does not exist, it is returned as undefined. Always check if the result is undefined before using it!
   
    Source:
    https://stackoverflow.com/questions/13328676/c-solving-cubic-equations
    Adapted to GML by TheSnidr
*/
var a = argument0;
var b = argument1;
var c = argument2;
var d = argument3;

var x1Re = undefined;
var x1Im = undefined;
var x2Re = undefined;
var x2Im = undefined;
var x3Re = undefined;
var x3Im = undefined;

if (a == 0)
{
    if (b == 0)
    {
        if (c == 0)
        {
            //This is a line without roots
            return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];
        }
        //This is a straight line
        x1Re = - d / c;
        x1Im = 0;
        return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];
    }
    //This is a quadratic polynomial
    var term1 = c * c - 4 * b * d;
    b *= 2;
    if (term1 > 0)
    {
        //The equaction has two real roots
        term1 = sqrt(term1);
        x1Re = (- c + term1) / b;
        x1Im = 0;
        x2Re = (- c - term1) / b;
        x2Im = 0;
        return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];
    }
    if (term1 == 0)
    {
        //The equation only has one root, which is real
        x1Re = - c / b;
        x1Im = 0;
        return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];
    }
    //The equation has two complex roots
    x1Re = - c / b;
    x1Im = sqrt(-term1) / b;
    x2Re = - c / b;
    x2Im = - x1Im;
    return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];
}

//This is a third degree polynomial
b /= a;
c /= a;
d /= a;

var q = (3 * c - b * b) / 9;
var r = (- 27 * d + b * (9 * c - 2 * b * b)) / 54;
var disc = q * q * q + r * r;
var term1 = b / 3;

if (disc > 0)
{
    //One root is real, two are complex
    var s = r + sqrt(disc);
    s = sign(s) * power(abs(s), 1 / 3);
    var t = r - sqrt(disc);
    t = sign(t) * power(abs(t), 1 / 3);
   
    x1Re = -term1 + s + t;
    term1 += (s + t) * .5;
    x2Re = -term1;
    x3Re = -term1;
    term1 = sqrt(3) * (s - t) * .5;
    x1Im = 0;
    x2Im = term1;
    x3Im = -term1;
    return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];
}

if (disc == 0)
{
    //All roots real, at least two are equal
    var r13 = sign(r) * power(abs(r), 1 / 3);
    x1Re = -term1 + 2 * r13;
    x1Im = 0;
    if r13 != 0
    {
        x2Re = -term1 - r13;
        x2Im = 0;
    }
    return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];
}

//Only option left is that all roots are real and unequal
q = -q;
var dum1 = arccos(r / sqrt(q * q * q));
var r13 = 2 * sqrt(q);
x1Re = -term1 + r13 * cos(dum1 / 3);
x2Re = -term1 + r13 * cos((dum1 + 2 * pi) / 3);
x3Re = -term1 + r13 * cos((dum1 + 4 * pi) / 3);
x1Im = 0;
x2Im = 0;
x3Im = 0;
return [x1Re, x1Im, x2Re, x2Im, x3Re, x3Im];