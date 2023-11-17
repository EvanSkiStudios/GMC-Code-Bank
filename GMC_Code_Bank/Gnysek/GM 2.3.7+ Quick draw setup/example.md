Quick setup for draw (2.3.7+, as this uses new omitting args + nullish operator features):

```gml
draw_setup(color = undefined, alpha = undefined, font = undefined, halign = undefined, valign = undefined)
```

example usages:  
```gml
//color + alpha change
draw_setup(c_red, 0.5);
// change font aligment only
draw_setup(,,,fa_center,fa_middle)
// change font + alpha + vertical align
draw_setup(,0.5,font_something,,fa_bottom);
```