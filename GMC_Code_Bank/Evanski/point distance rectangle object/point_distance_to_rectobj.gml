function point_distance_to_rectobj( px,py, obj ){
    /*
    by wamingo
    https://www.reddit.com/r/gamemaker/comments/92x9ws/finding_the_distance_from_a_point_to_the_edge_of/
    
        returns distance to the bounding box of an object,
        or 0 if point lies anywhere inside it.

        Note: limited to rectangular bounding boxes!

        based on: https://gamedev.stackexchange.com/questions/44483/how-do-i-calculate-distance-between-a-point-and-an-axis-aligned-rectangle
    */
    ///@func point_distance_to_rectobj( px,py, obj )
    ///@arg px
    ///@arg py
    ///@arg obj
    var n  = obj;
    var cx = max(min(px, n.bbox_right ), n.bbox_left);
    var cy = max(min(py, n.bbox_bottom), n.bbox_top);
    return sqrt( (px-cx)*(px-cx) + (py-cy)*(py-cy) );
}