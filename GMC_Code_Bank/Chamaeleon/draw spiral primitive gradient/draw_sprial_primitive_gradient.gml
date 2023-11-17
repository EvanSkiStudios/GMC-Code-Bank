function draw_spiral_primitive_gradient(xc, yc, sprite, subimage, width, final_angle, angle_step, radius_step) {
    var texture = sprite_get_texture(sprite, subimage);
    var segment_radius_step = radius_step * angle_step/360;
    var radius = 0;
    var segment_counter = 0;
    draw_primitive_begin_texture(pr_trianglestrip, texture);
    for (var angle = 0; angle <= final_angle; {angle += angle_step; radius += segment_radius_step}) {
        var texture_x = angle/final_angle;
        var _xx = xc + lengthdir_x(radius, angle);
        var _yy = yc + lengthdir_y(radius, angle);
        draw_vertex_texture(_xx + lengthdir_x(width/2, angle), _yy + lengthdir_y(width/2, angle), texture_x, 0);
        draw_vertex_texture(_xx - lengthdir_x(width/2, angle), _yy - lengthdir_y(width/2, angle), texture_x, 1);
        if (++segment_counter == 256) {
            draw_primitive_end();
            draw_primitive_begin_texture(pr_trianglestrip, texture);
            segment_counter = 0;
            angle -= angle_step;
        }
    }
    draw_primitive_end();
}