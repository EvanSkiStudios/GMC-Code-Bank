Alphabetized "Maps" (maybe could be called alphamaps)
Searching for things by name usually is a linear scan through a list, but with alphamaps™ you can add them to an array structure based on what letter they begin with, and end with, so in most cases it narrows the amount of names down so that each name has it's own slot, with only a few others in the same slot, which reduces search iterations by about 90%
So instead of iterating through a list 50 times before it gets to the name it's searching for, it simply gets 2 grid coordinates, the cell with the ord value of the first character on the x axis and the ord of the last character on the y axis, then the cell will only contain a few things and will only have to iterate 3 or so times.

So, the search function is this:
```
map_search(map, name)
```

To create a map to begin with:
```
map_create()
```

Then to add things to the map:
```
map_add(map, thing)
```

and the wrap function is this:
```
wrap(val, min, max)
```

I did make a newer version of wrap using frac, but I kind of made it then forgot to update my project with it so it's still this at the moment, it's hardly any slower though cus in this case it's just used to make numbers wrap and become part of the alphabet, so things like "Thing 1" "Thing 2" will be classed as "Thing A" "Thing B" and have different slots in the map.

And "float(0)" is just a quick way I use of making a blank array with only 1 (0) index:

```gml
var a;
a[0] = argument0
return a
```

But you may aswell just use this:
```
///array_init()
var a;
a[0] = 0
return a
```

I also always use the [0] index of arrays to hold how many things are in the array\list, instead of using array_length, so that's what the "c[0]" is used for. You can of course change this and use array_length and start the values at 0. I just do it this way cus I like the 1st thing in a list to have the index of 1, and the 39th to have the index of 39, instead of 38. It just seems ridiculous to always have to subtract 1. If it was up to me the 0 index wouldn't exist and it would start at 1, but hay ho :D