function yaw_pitch_length(yaw, pitch, length) {

//Creates a 3d vector(3 component array)

    var l = lengthdir_x(length, pitch);

    return [lengthdir_x(l, yaw), lengthdir_y(l, yaw), lengthdir_y(length, pitch)]
}