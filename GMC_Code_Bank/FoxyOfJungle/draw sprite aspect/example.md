Simple function to draw a sprite with aspect ratio that's fit an area:

```gml
draw_sprite_aspect(sprite, subimage, x, y, xscale, yscale, rot, col, alpha, areaw, areah)
```

Original sprite size: 720 x 320
GUI size: 720 x 1280


Usage one:
```gml
var scale = device_mouse_x_to_gui() / display_get_gui_width();
draw_sprite_aspect(spr_studio_logo, 0, display_get_gui_width()/2, display_get_gui_height()/2, scale, scale, 0, c_white, 1, display_get_gui_width(), 0);
```

![](https://i.imgur.com/hxXVTBL.gif)

Usage two:
```gml
var scale = device_mouse_y_to_gui() / display_get_gui_height();
draw_sprite_aspect(spr_studio_logo, 0, display_get_gui_width()/2, display_get_gui_height()/2, scale, scale, 0, c_white, 1, 0, display_get_gui_height());
```
![](https://i.imgur.com/fr2JlUe.gif)

