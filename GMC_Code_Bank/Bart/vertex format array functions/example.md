Whe working with [vertex formats](https://manual.yoyogames.com/GameMaker_Language/GML_Reference/Drawing/Primitives/Primitives_And_Vertex_Formats.htm) it can be more convenient to store the function names you'd normally use to add attributes (vertex_format_add_*) in an array and then consider that array as the "vertex format". It allows for some extra functions to get more info out, such as the format size (in bytes) and individual attribute sizes (also in bytes). Getting correct values out of GM where possible is always better than hard-coding them yourself.
(These two functions are basically the continuation of [an earlier post on this](https://forum.gamemaker.io/index.php?threads/code-bank-share-useful-code.60575/page-3#post-545936))

## vertex_attribute_sizes
Given an array containing any of the vertex_format_add_* function identifiers, returns an array with the number of bytes taken by the respective vertex attributes (all components):  
```gml
vertex_attribute_sizes(_arr_format)
```

## vertex_format_from_array
Creates a vertex format from an array containing any of the vertex_format_add_* functions:  
```gml
vertex_format_from_array(_arr_format)
```

You can then use these in your code as follows:  
```gml
// "Define" the format
arr_format_description = [
    vertex_format_add_position_3d,
    vertex_format_add_normal,
    vertex_format_add_color,
    vertex_format_add_texcoord
];

// Get the number of bytes per attribute
arr_sizes = vertex_attribute_sizes(arr_format_description);
show_debug_message(arr_sizes);    // Outputs [12, 12, 4, 8] (i.e. [3*4, 3*4, 4*1, 2*4])

// Create the actual vertex format from the array
format = vertex_format_from_array(arr_format_description);

// Use the vertex format
vb = vertex_create_buffer();
vertex_begin(vb, format);
// vertex_position_3d(), etc. here
vertex_end(vb);
```