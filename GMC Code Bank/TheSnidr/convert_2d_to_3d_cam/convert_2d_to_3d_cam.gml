/// @func convert_2d_to_3d_cam(camera, x, y)
function convert_2d_to_3d_cam(camera, _x, _y)
{
    /*
    Transforms a 2D coordinate (in window space) to a 3D vector.
    Returns an array of the following format:
    [dx, dy, dz, ox, oy, oz]
    where [dx, dy, dz] is the direction vector and [ox, oy, oz] is the origin of the ray.
    Works for both orthographic and perspective projections.
    Script created by TheSnidr
    */
    var V = camera_get_view_mat(camera);
    var P = camera_get_proj_mat(camera);
    var mx = 2 * (_x / window_get_width()  - .5) / P[0];
    var my = 2 * (_y / window_get_height() - .5) / P[5];
    var camX = - (V[12] * V[0] + V[13] * V[1] + V[14] * V[2]);
    var camY = - (V[12] * V[4] + V[13] * V[5] + V[14] * V[6]);
    var camZ = - (V[12] * V[8] + V[13] * V[9] + V[14] * V[10]);
    if (P[15] == 0)
    {    //This is a perspective projection
        return [V[2]  + mx * V[0] + my * V[1],
                V[6]  + mx * V[4] + my * V[5],
                V[10] + mx * V[8] + my * V[9],
                camX,
                camY,
                camZ];
    }
    else
    {    //This is an ortho projection
        return [V[2],
                V[6],
                V[10],
                camX + mx * V[0] + my * V[1],
                camY + mx * V[4] + my * V[5],
                camZ + mx * V[8] + my * V[9]];
    }
}

/// @func convert_3d_to_2d_cam(camera, x, y, z)
function convert_3d_to_2d_cam(camera, _x, _y, _z)
{
    /*
        Transforms a 3D coordinate to a 2D coordinate. Returns an array of the following format:
        [x, y]
        where x and y are between (0, 0) (top left) and (1, 1) (bottom right) of the screen
        Returns [-1, -1] if the 3D point is behind the camera

        Works for both orthographic and perspective projections.

        Script created by TheSnidr
        www.thesnidr.com
    */
    var V = camera_get_view_mat(camera);
    var P = camera_get_proj_mat(camera);
    var w = V[2] * _x + V[6] * _y + V[10] * _z + V[14];
    if (w <= 0)
    {
        return [-1, -1];
    }
    var cx, cy;
    if (P[15] == 0)
    {    //This is a perspective projection
        cx = P[8] + P[0] * (V[0] * _x + V[4] * _y + V[8] * _z + V[12]) / w;
        cy = P[9] + P[5] * (V[1] * _x + V[5] * _y + V[9] * _z + V[13]) / w;
    }
    else
    {    //This is an ortho projection
        cx = P[12] + P[0] * (V[0] * _x + V[4] * _y + V[8]  * _z + V[12]);
        cy = P[13] + P[5] * (V[1] * _x + V[5] * _y + V[9]  * _z + V[13]);
    }
    return [.5 + .5 * cx, .5 - .5 * cy];
}