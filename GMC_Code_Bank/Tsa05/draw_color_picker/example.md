```
draw_color_picker(x, y, w, h, ds_list);
```

You make a ds list containing color info in the form of [R,G,B] arrays. This script draws a series of color picker boxes with those colors, fitting within the width and height desired. The script also returns the index of the color that you're currently hovering over, so that you can store it to an instance variable and use it on clobal mouse click, etc. Returns -1 if you're not hovering over a color.