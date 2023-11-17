Another maybe useful maybe not-so-useful thing: A physics script for elastic collisions - only to be used inside a collision event in lieu of GM's built in physics. Uses the built in variables speed and direction to keep things simple.
_m1 and _m2 are the relative masses of the colliding objects, _x1, _y1 etc. are the relative positions of each object, other is just well... the keyword other. Maybe someone can find a good use for it, or make it better using true vectors.

// Probably should use a bool to make sure this only happens once per specified interval though, otherwise it might get spooky.  
example:   
```gml
elastic_collision(sprite_width, other.sprite_width, x, y, other.x, other.y, other);
```

Video:  
[![](https://i.ytimg.com/vi/V9-wOg65kGA/sddefault.jpg?sqp=-oaymwEmCIAFEOAD8quKqQMa8AEB-AH6CYAC0AWKAgwIABABGDQgZSg-MA8=&rs=AOn4CLCKLV-EPE2jeSdSViHih3FZ9B6FRQ)](https://www.youtube.com/watch?v=V9-wOg65kGA)