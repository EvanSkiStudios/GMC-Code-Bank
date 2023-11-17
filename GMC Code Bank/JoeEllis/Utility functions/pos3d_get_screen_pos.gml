function pos3d_get_screen_pos(_x, _y, _z) {

//Gets the position on the screen of a 3d coordinate, given the current view & projection matrices
//Requires global.matrix_world_view_projection to be pre calculated before hand,
//Ideally just after the view & projection matrices have been set:
//global.matrix_world_view_projection =
//matrix_multiply(matrix_get(matrix_world), matrix_multiply(matrix_get(matrix_view), matrix_get(matrix_projection)))

    var pos = matrix_transform_vertex(global.matrix_world_view_projection, _x, _y, _z);
  
    _z = pos[2] + 1

    //If the depth is "behind" the view focal point(xyz_from), set to -10000 so it's off the screen
    if _z < 0
    {return [-10000, -10000, _z]}

    //Convert the position from clip space to pixel space:
    pos[0] = (1 + (pos[0] / _z)) * 0.5 * screen_width
    pos[1] = (1 - (pos[1] / _z)) * 0.5 * screen_height
    return pos
}
