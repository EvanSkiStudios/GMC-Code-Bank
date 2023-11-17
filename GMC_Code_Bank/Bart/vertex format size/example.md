GameMaker has no built-in function to retrieve the size in bytes of a vertex format, yet the information is there somewhere.
The following function works out the size in bytes of a given vertex format by copying a single vertex from a buffer and then getting the size of the resulting vertex buffer:

```gml
vertex_format_size(format)
```

Example use:  
```gml
// 3D position only
vertex_format_begin();
vertex_format_add_position_3d();
format = vertex_format_end();

size = vertex_format_size(format);
show_debug_message(size);    // 12

// Default passthrough format
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_colour();
vertex_format_add_texcoord();
format = vertex_format_end();

size = vertex_format_size(format);
show_debug_message(size);    // 24
```