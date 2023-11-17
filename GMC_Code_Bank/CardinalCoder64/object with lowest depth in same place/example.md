In cases where you need to find the instance ID of an object with the lowest depth among objects stacked on top of each other in a single point, I've created a function that does just that. For instance (pun intended), if you need to mouse click on an object that overlaps another object, the function will return the object with the lowest depth (i.e. the object on top) rather than both objects at once. This can be useful especially for selecting objects that are stacked on top of each other. I have dubbed this function "instance_top". Works with precise collisions and the "all" keyword.

```gml
instance_top(argument0,argument1,argument2)
```

To use, simply store the return value of the function in a variable. Then if desired, you can use the instance ID to do whatever you need to do.
```gml
var top_inst = instance_top(mouse_x,mouse_y,all);
if top_inst != noone {
    //do stuff
}
```