function draw_path_primitive_gradient(path, sprite, subimage, width, segments) {
    var texture = sprite_get_texture(sprite, subimage);
    var segment_counter = 0;
    draw_primitive_begin_texture(pr_trianglestrip, texture);
    var old_dir = 0;
    for (var i = 0; i <= segments; ++i) {
        var fraction = i/segments;
        var xp = path_get_x(path, fraction);
        var yp = path_get_y(path, fraction);
        var dx = path_get_x(path, fraction + 1/(10*segments)) - xp;
        var dy = path_get_y(path, fraction + 1/(10*segments)) - yp;
        if (i < segments)
            var dir = point_direction(0, 0, dx, dy);
        else
            var dir = old_dir;
        old_dir = dir;
        var wx = lengthdir_x(width/2, dir+90);
        var wy = lengthdir_y(width/2, dir+90);
        draw_vertex_texture(xp + wx, yp + wy, fraction, 0);
        draw_vertex_texture(xp - wx, yp - wy, fraction, 1);
        if (++segment_counter == 256) {
            draw_primitive_end();
            draw_primitive_begin_texture(pr_trianglestrip, texture);
            segment_counter = 0;
            --i;
        }
    }
    draw_primitive_end();
}