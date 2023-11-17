function vec3_to_yaw_pitch(vx, vy, vz) {

//Gets the yaw, pitch and length of a vector and returns a vec3 array

    return [
    point_direction(0, 0, vx, vy),
    point_direction(0, 0, point_distance(0, 0, vx, vy), vz),
    point_distance_3d(0, 0, 0, vx, vy, vz)]
}