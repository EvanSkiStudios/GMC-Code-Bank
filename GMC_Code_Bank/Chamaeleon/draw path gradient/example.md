Drawing a path with a texture in a similar manner to the gradient spiral  

Create event  
```gml
path = path_add();
path_set_closed(path, false);

for (var i = -128; i <= 128; ++i) {
    var angle = i/256*4*pi;
    var xp = 50*angle + window_get_width()/2;
    var yp = 100*sin(angle) + window_get_height()/2;
    path_add_point(path, xp, yp, 100);
}
```

Draw Event:  
```gml
draw_path_primitive_gradient(path, spr_gradient, 0, 20, 200);
```

Result using the same gradient as the spiral  
![](https://forum.gamemaker.io/index.php?attachments/sine-gradient-png.50053/)

(Edit: Both the spiral and the path drawing code was written somewhat in haste, and can probably use optimizations and quite possibly has corner case bugs)