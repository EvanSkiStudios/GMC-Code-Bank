function clamp_vec3(_x, _y, _z, _max) {

//Clamps the length of a vector whilst maintaining the direction

    var d = point_distance_3d(0, 0, 0, _x, _y, _z);

    if d > _max
    {
    d = _max / d
    return [_x * d, _y * d, _z * d]
    }

    return [_x, _y, _z]
}