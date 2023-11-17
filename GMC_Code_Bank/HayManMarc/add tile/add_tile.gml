/// @description add_tile(tileset_layer, tileset_index, xx, yy)
/// @param tileset_layer  the layer name of the tile layer (must use quotes)
/// @param tileset_index   the integer value that represents the position of the tile
/// @param xx  x position in room for tile
/// @param yy  y position in room for tile

function add_tile(tileset_layer, tileset_index, xx, yy){

var lay_id = layer_get_id(tileset_layer);
var map_id = layer_tilemap_get_id(lay_id);
var data = tilemap_get_at_pixel(map_id, xx, yy);
data = tile_set_index(data, tileset_index);
tilemap_set_at_pixel(map_id, data, xx, yy);
}