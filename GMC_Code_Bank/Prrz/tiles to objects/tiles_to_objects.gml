function tiles_to_objects(tile_layer, instance_layer, obj) {
   
    var _layer_id = layer_get_id(tile_layer);
    var _map_id = layer_tilemap_get_id(_layer_id);
    var _tile_w = tilemap_get_tile_width(_map_id);
    var _tile_h = tilemap_get_tile_height(_map_id);
   
    for(var i = 0; i <= room_width; i += _tile_w) {
        for(var j = 0; j <= room_height; j += _tile_h) {
            if(tilemap_get_at_pixel(_map_id, i, j) > 0) {
                instance_create_layer(i, j, instance_layer, obj);
            }
        }
    }
   
    layer_tilemap_destroy(_map_id);
}