Drawing a spiral with width and colored by a sprite. Segment counter is used to start a new triangle strip after some number of segments as there is a maximum number of points it can contain (the subtraction angle -= angle_step is to avoid a gap due to the increment at the end of each for loop iteration).  

Draw event  
```gml
var width = window_get_width();
var height = window_get_height();

draw_spiral_primitive_gradient(width/2, height/2, spr_gradient, 0, 20, 10*360, 2, 30);
```
spr_gradient  
![](https://forum.gamemaker.io/index.php?attachments/0f90888d-a500-4b7d-a4e1-39369fd1fc0c-png.50052/)

Result  
![](https://forum.gamemaker.io/index.php?attachments/gradient-spiral-png.50051/)

