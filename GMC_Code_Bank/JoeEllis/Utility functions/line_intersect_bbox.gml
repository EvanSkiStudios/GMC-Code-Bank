function line_intersect_bbox(lx1, ly1, lz1, lx2, ly2, lz2, bbox_x1, bbox_y1, bbox_z1, bbox_x2, bbox_y2, bbox_z2) {

    //Detects whether a 3d line\ray intersects a 3d bounding box
    //and returns the intersect position if there is one.
    //Useful for bullet collisions
    //Based on the SLAB method (Look it up!)
  
    var
    tmin = -10000000,
    tmax = 10000000,
    nx, ny, nz, d, v1, v2;

    nx = lx2 - lx1
    ny = ly2 - ly1
    nz = lz2 - lz1
    d = 1 / point_distance_3d(0, 0, 0, nx, ny, nz)
    nx *= d
    ny *= d
    nz *= d

    if nx != 0.0
    {
    v1 = (bbox_x1 - lx1) / nx
    v2 = (bbox_x2 - lx1) / nx
    tmin = max(tmin, min(v1, v2))
    tmax = min(tmax, max(v1, v2))
    }

    if ny != 0.0
    {
    v1 = (bbox_y1 - ly1) / ny
    v2 = (bbox_y2 - ly1) / ny
    tmin = max(tmin, min(v1, v2))
    tmax = min(tmax, max(v1, v2))
    }

    if nz != 0.0
    {
    v1 = (bbox_z1 - lz1) / nz
    v2 = (bbox_z2 - lz1) / nz
    tmin = max(tmin, min(v1, v2))
    tmax = min(tmax, max(v1, v2))
    }

    if tmax >= tmin
    {return [lx1 + (nx * tmin), ly1 + (ny * tmin), lz1 + (nz * tmin)]}

    return 0
}