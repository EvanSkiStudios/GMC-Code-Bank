The following script allows you to draw a texture group's layout while running the game, which might come in handy for debugging purposes.
It basically shows the same information as the texture preview option in the game options.
You can modify it further by adding specific colors for each resource type, by choosing which resource type to draw, etc.

Using the script:
```gml
/// Draw event
dbg_draw_texgroup(x, y, "Default");
```