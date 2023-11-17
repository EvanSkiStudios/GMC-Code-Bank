Generalized picking an item out of a collection with variable frequency.

```gml
RandomBag() constructor
```

```gml
var bag = new RandomBag();

bag.add("Foo", 10);
bag.add("Bar", 20);
bag.add("Baz", 70);

var foo_count = 0;
var bar_count = 0;
var baz_count = 0;

repeat 10000 {
    var thing = bag.pick();
    if (thing == "Foo") foo_count++;
    else if (thing == "Bar") bar_count++;
    else if (thing == "Baz") baz_count++;
}

show_debug_message("Foo count is " + string(foo_count));
show_debug_message("Bar count is " + string(bar_count));
show_debug_message("Baz count is " + string(baz_count));
```

```
Foo count is 1012
Bar count is 2017
Baz count is 6971
```

10 + 20 + 70 = 100.   
Foo should be picked 10 times out of 100 on average, Bar should be picked 20 times out of 100, and Baz should be picked 70 times out of 100.  

The frequencies does not need to add up to any particular target like 100. It's all relative between each entry and the total sum.  
Could be used for picking random instances for creation  

```gml
var bag = new RandomBag();
bag.add(obj_foo, 4);
bag.add(obj_bar, 1);
instance_create_layer(x, y, "Instances", bag.pick());
```

The above code will create obj_foo 80% (4/(1+4)) of time and obj_bar 20% (1/(1+4)) of the time.