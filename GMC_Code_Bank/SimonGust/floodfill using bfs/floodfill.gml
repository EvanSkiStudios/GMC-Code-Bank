function bfs256x256(point_count=10)
{
    static bfs_neighbours = [-256, -1, +256, +1];
   
    var result = array_create(65536, 0);
    var points = array_create(65536, 0);
    var first = 0;
   
    // set starting points
    for (var n = 0; n < point_count; n++) {
        var pos = irandom(256) | irandom(256) << 8;
        var key = (irandom(255) + 1) << 16;
        result[pos] = key;
        points[n] = pos | key;
    }
   
    while (first < point_count)
    {
        // get first entry (that hasn't been already checked)
        var vertex = points[first++];
        var pos = vertex & 65535;
        var key = vertex & 4294901760;
       
        // go through neighbours
        for (var n = 0; n < 4; n++)
        {
            // is it inside the grid
            var npos = pos + bfs_neighbours[n];
            if (npos < 0 or npos > 65535) {
                continue;   
            }

            // is it not yet registered
            if (result[npos] == 0) {
                result[npos] = key;
                points[point_count++] = npos | key;
            }
        }
    }
   
    return result;
}