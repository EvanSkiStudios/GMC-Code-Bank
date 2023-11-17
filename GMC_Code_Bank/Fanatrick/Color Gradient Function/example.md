```gml
var _grad = [c_red, c_green, c_blue],
    _val = 0.5 + sin(current_time * 0.001) * 0.5,
    _col = color_gradient(_grad, _val);
```