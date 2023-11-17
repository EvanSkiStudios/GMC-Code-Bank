///map_search(map, name)

var m = argument0, name = argument1;

var
i = wrap(ord(string_char_at(name, 1)), 0, 26),
j = wrap(ord(string_char_at(name, string_length(name))), 0, 26);
var c = m[i, j], n;
if c != 0
{
n = c[_mapcell.names]
i = 0
repeat n[0]
{
if n[++i] = name
{
n = c[_mapcell.nodes]
return n[i]
}
}
}
return 0

///map_create()

var m, i = -1;

repeat 26
{m[++i, 25] = 0}

return m

///map_add(map, thing)

var m = argument0, n = argument1;

var name = n[_node.name];
var
i = wrap(ord(string_char_at(name, 1)), 0, 26),
j = wrap(ord(string_char_at(name, string_length(name))), 0, 26);

var c = m[i, j];
if c = 0
{
c[_node.type] = _type.mapcell
c[_mapcell.map] = m
c[_mapcell.i] = i
c[_mapcell.j] = j
c[_mapcell.names] = float(0)
c[_mapcell.nodes] = float(0)
m[@ i, j] = c
}

var l = c[_mapcell.nodes];
l[@ ++l[@ 0]] = n
l = c[_mapcell.names]
l[@ ++l[@ 0]] = n[_node.name]

///wrap(val, min, max)

var val = argument0;
var min_val = argument1;
var max_val = argument2;
var delta = abs(min_val - max_val);

if min_val = max_val
{return min_val}

if val < min_val
{
while val < min_val
{val += delta}
}

if val >= max_val
{
while val >= max_val
{val -= delta}
}

return val