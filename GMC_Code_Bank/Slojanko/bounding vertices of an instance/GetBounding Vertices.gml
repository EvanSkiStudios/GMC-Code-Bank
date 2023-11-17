function Vec2(x_, y_) constructor {
    x = x_;
    y = y_;
}

function GetBoundingVertices(){
    var array = array_create(4, 0);
    var matrix = matrix_build(x, y, 0, 0, 0, image_angle, 1, 1, 1);
  
    // sprite_offset already account for scale
    var transformed = matrix_transform_vertex(matrix, -sprite_xoffset, -sprite_yoffset, 0);
    array[0] = new Vec2(transformed[0], transformed[1]);
    transformed = matrix_transform_vertex(matrix, sprite_width-sprite_xoffset, -sprite_yoffset, 0);
    array[1] = new Vec2(transformed[0], transformed[1]);
    transformed = matrix_transform_vertex(matrix, -sprite_xoffset, sprite_height-sprite_yoffset, 0);
    array[2] = new Vec2(transformed[0], transformed[1]);
    transformed = matrix_transform_vertex(matrix, sprite_width-sprite_xoffset, sprite_height-sprite_yoffset, 0);
    array[3] = new Vec2(transformed[0], transformed[1]);
  
    return array;
}