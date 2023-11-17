```
is_in(value, test1, test2, test3, ...) 
```
OR
```
is_in(value, array)
```

Described in function, and I submitted it to the gmlscripts.com forums, too.
Basically, if I want to test whether x, y, or z is equal to a value, that requires a longish IF statement.
If I'm ok with potentially sacrificing some short-circuit probabilities, I can use this:
```
if is_in(value, x, y, x) 
```
OR
```
if is_in(value, [x, y, z])
```
(Which can be especially useful if the array is populated elsewhere)