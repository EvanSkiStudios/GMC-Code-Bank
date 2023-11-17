It is possible in GameMaker to get the uvs for just about everything on a texture page but not for particles. The following function fixes that. It gets the uvs on the texture page for a given particle type shape (pt_shape_).
It requires a very basic shader that is used to output the uv info to a surface, which is then read into a buffer using buffer_get_surface.

Use as follows:  
```gml
var _uv_info = part_type_get_uvs(pt_shape_cloud);
```

The function returns an array with the following information:

0. left (u)
1. top (v)
2. right (u)
3. bottom (v)
4. image width on the texture page (in pixels)
5. image height on the texture page (in pixels)
6. texel width
7. texel height

Shd_ouput_uv  
```GLSL ES
//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;

void main()
{
    vec4 object_space_pos = vec4( in_Position, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;

    v_vTexcoord = in_TextureCoord;
}

//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

void main()
{
    vec4 temp = texture2D(gm_BaseTexture, v_vTexcoord);     // FORCE a lookup!
    gl_FragColor = vec4(v_vTexcoord, .5, max(1., temp.a));
}
```

Note that pt_shape_pixel gives mostly wrong results. Though you can still get this info out by using the information from other shapes (texel dimensions are identical as the images are on the same texture page).