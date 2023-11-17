/// dbg_draw_texgroup(x, y, texgroup_name)
var _x = argument0;
var _y = argument1;
var texgroup_name = argument2;

var arr_sprites = texturegroup_get_sprites(texgroup_name);
var arr_fonts = texturegroup_get_fonts(texgroup_name);
var arr_tilesets = texturegroup_get_tilesets(texgroup_name);

var len_sprites = array_length_1d(arr_sprites);
var len_fonts = array_length_1d(arr_fonts);
var len_tilesets = array_length_1d(arr_tilesets);

if (len_sprites == 0 && len_fonts == 0 && len_tilesets == 0) {
    // Nothing to draw
    return;
}

// Get texture page dimensions from the first resource we can find on the page
var resource, tex;
if (len_sprites > 0) {
    var resource = arr_sprites[0];
    var tex = sprite_get_texture(resource, 0);
} else if (len_fonts > 0) {
    var resource = arr_fonts[0];
    var tex = font_get_texture(resource);
} else if (len_tilesets > 0) {
    var tls = arr_tilesets[0];
    var tex = tileset_get_texture(arr_tilesets[0]);
}
var w = 1/texture_get_texel_width(tex);
var h = 1/texture_get_texel_height(tex);

// Keep things tidy by storing the current draw color
var c = draw_get_color();

// Now change the color
draw_set_color(c_red);
draw_rectangle(_x, _y, _x + w, _y + h, true);
draw_set_color(c_white);

// Loop through all different resources that take up space on a texture
for(var i = 0;i < len_sprites;i++) {
    var spr = arr_sprites[i];
    var arr_uvs = sprite_get_uvs(spr, 0);
    draw_rectangle(_x + arr_uvs[0]*w, _y + arr_uvs[1]*h, _x + arr_uvs[2]*w, _y + arr_uvs[3]*h, true);
    draw_text(_x + arr_uvs[0]*w, _y + arr_uvs[1]*h, sprite_get_name(spr));
}

for(var i = 0;i < len_fonts;i++) {
    var fnt = arr_fonts[i];
    var arr_uvs = font_get_uvs(fnt);
    draw_rectangle(_x + arr_uvs[0]*w, _y + arr_uvs[1]*h, _x + arr_uvs[2]*w, _y + arr_uvs[3]*h, true);
    draw_text(_x + arr_uvs[0]*w, _y + arr_uvs[1]*h, font_get_name(fnt));
}

for(var i = 0;i < len_tilesets;i++) {
    var tls = arr_tilesets[i];
    var arr_uvs = tileset_get_uvs(tls);
    draw_rectangle(_x + arr_uvs[0]*w, _y + arr_uvs[1]*h, _x + arr_uvs[2]*w, _y + arr_uvs[3]*h, true);
    draw_text(_x + arr_uvs[0]*w, _y + arr_uvs[1]*h, tileset_get_name(tls));
}

// Restore draw state
draw_set_color(c);