This workaround has limited application, as they may fix this in the future. But draw_rectangle() is currently bugged in GMS and it draws one pixel width of an outline regardless of how many pixels it should be upscaling depending on room and view related stuff. For example, you're view could be zoomed in by 200% and the line would make sense to be 2 pixels thick, instead it is still one pixel thick.

Here's a function you can use that respects room and view zooming and window resizing / scaling....

```gml
draw_rectangle_patched(x1, y1, x2, y2, outline)
```

....where as "spr_DrawRectFix" is a 1x1 pixel solid white color filled sprite.

Replace "2" with the desired pixel thickness -- search -> replace all (whole word only).

Probably other drawing primitives are also broken in the same manner. You can fix that similarly to this approach.