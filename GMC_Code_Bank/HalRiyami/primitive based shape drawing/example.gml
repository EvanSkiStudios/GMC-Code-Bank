A bunch of primitive based shape drawing functions. The precision (for arc, circle, and capsule) is hardcoded at 15 degrees by you can change that to whatever you want.

```gml

draw_line_advanced(_x1, _y1, _x2, _y2, _width, _color)

draw_arc_advanced(_x, _y, _r, _angle, _span, _width, _color)

draw_rectangle_advanced(_x1, _y1, _x2, _y2, _color, _outline, _width)

draw_circle_advanced(_x, _y, _r, _color, _outline, _width)

draw_capsule_advanced(_x1, _y1, _x2, _y2, _r, _color, _outline, _width)

draw_polygon_advanced(_polygon, _color, _outline, _width)
```