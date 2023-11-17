/// @func convert_3d_to_2d(viewMat, projMat, x, y, z)
function convert_3d_to_2d(V, P, _x, _y, _z)
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