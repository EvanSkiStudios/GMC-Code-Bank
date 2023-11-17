Make a bounding box stretches to fit the window as requested. If stretch_mode is NONE, then the bounding box is not stretched and is centered in the window. If stretch_mode is ASPECT, then the bounding box is centered on the window, and stretched such that it maintains its aspect ratio, but is as large as possible to fit within the window. If Stretching is FULL, then it returns the bounding box of the window.

By "game window" referenced in the manual for what the window's width and height is, I believe they mean the back buffer within the window that is drawn to the screen.

```gml
stretched_to_fit_window( width, height, stretch_mode )
```