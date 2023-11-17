A naive translation of the Poisson Disk sampling algorithm from https://sighack.com/post/poisson-disk-sampling-bridsons-algorithm

Sample usage
Create event  
```gml
var disk = new PoissonDisk(400, 400, 32, 10);
points = disk.generate();
```

Draw event  
```gml
var i = 0;
repeat array_length(points) {
    draw_circle(points[i].x, points[i].y, 8, true);
    i++;
}
```

Array content returned from the generate() function.  
```
[ { x : 360.77, y : 323.51 },{ x : 320.31, y : 310.53 },{ x : 318.73, y : 362.06 }, ... ]
```
![](https://forum-storage.yoyogames.com/data/attachments/47/47978-db87e70f9f7a993897f7e343f7ea2253.jpg)