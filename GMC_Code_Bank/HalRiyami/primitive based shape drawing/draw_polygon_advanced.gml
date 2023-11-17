///    @func                draw_polygon_advanced()
///    @param    {array}        polygon        A closed convex polygon array structure [x1, y1, x2, y2, x3, y3,...].
///    @param    {integer}    color        The color of the polygon.
///    @param    {boolean}    outline        Whether the polygon is drawn filled (false) or as an outline (true).
///    @param    {integer}    width        The width of the outline (in pixels). Ignored of filled.
function draw_polygon_advanced(_polygon, _color, _outline, _width) {
    var _vertexCount    = array_length(_polygon)/2;
    var _i = 0;
    // Filled case
    if (!_outline) {
        draw_primitive_begin(pr_trianglefan);
        repeat (_vertexCount) {draw_vertex_color(_polygon[_i*2], _polygon[_i*2 +1], _color, 1);    ++_i;}
        draw_primitive_end();
        exit;
    }
    // Outline with 0 width
    if (_width <= 0) {
        draw_primitive_begin(pr_linestrip);
        repeat (_vertexCount) {draw_vertex_color(_polygon[_i*2], _polygon[_i*2 +1], _color, 1);    ++_i;}
        draw_vertex_color(_polygon[0], _polygon[1], _color, 1);
        draw_primitive_end();
        exit;
    }
    
    // Outline with width
    var _m    = array_create(_vertexCount);    // Slopes
    var _bi    = array_create(_vertexCount);    // Inner edge intercepts
    var _bo    = array_create(_vertexCount);    // Outer edge intercepts
    // Loop to find the slope and intercepts of the inner and outer edges
    repeat (_vertexCount) {
        var _j    = (_i +1) % _vertexCount;
    
        var _vx    = _polygon[_j*2] -_polygon[_i*2];
        var _vy    = _polygon[_j*2 +1] -_polygon[_i*2 +1];
        var _d    = sqrt(_vx*_vx +_vy*_vy);
        var _nx    =  _vy*_width/2/_d;
        var _ny    = -_vx*_width/2/_d;
    
        _m[_i]    = _vy/_vx;
        _bo[_i]    = (_polygon[_i*2 +1] +_ny) -(_polygon[_i*2] +_nx)*_m[_i];
        _bi[_i]    = (_polygon[_i*2 +1] -_ny) -(_polygon[_i*2] -_nx)*_m[_i];
        
        ++_i;
    }
    // Draw loop
    var _i    = 0;
    draw_primitive_begin(pr_trianglestrip);
    repeat (_vertexCount +1) {
        var _j    = (_i +1) % _vertexCount;
        
        if (abs(_m[_i]) == infinity) {
            var _ox = _polygon[_i*2] +_nx;
            var _oy    = _m[_j]*_ox +_bo[_j];
            var _ix = _polygon[_i*2] -_nx;
            var _iy    = _m[_j]*_ix +_bi[_j];
        }
        else if (abs(_m[_j]) == infinity) {
            var _ox = _polygon[_j*2] +_nx;
            var _oy    = _m[_i]*_ox +_bo[_i];
            var _ix = _polygon[_j*2] -_nx;
            var _iy    = _m[_i]*_ix +_bi[_i];
        }
        else {
            var _ox    = (_bo[_j] -_bo[_i])/(_m[_i] -_m[_j]);
            var _oy    = _m[_i]*_ox +_bo[_i];
            var _ix    = (_bi[_j] -_bi[_i])/(_m[_i] -_m[_j]);
            var _iy    = _m[_i]*_ix +_bi[_i];
        }
        draw_vertex_color(_ox, _oy, _color, 1);
        draw_vertex_color(_ix, _iy, _color, 1);
        
        _i    = (_i +1) % _vertexCount;
    }
    draw_primitive_end();
}