///    @func                draw_circle_advanced()
///    @param    {real}        x            The x coordinate of the center of the circle.
///    @param    {real}        y            The y coordinate of the center of the circle.
///    @param    {real}        r            The radius (distance from center to edge) of the circle in pixels.
///    @param    {integer}    color        The color of the circle.
///    @param    {boolean}    outline        Whether the circle is an outline (true) or not (false).
///    @param    {integer}    width        The width of the outline in pixels. Ignored of filled.
function draw_circle_advanced(_x, _y, _r, _color, _outline, _width) {
    // Filled case
    if (!_outline) {
        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color(_x, _y, _color, 1);
        var _a = 360;
        repeat (360/15 +1) {draw_vertex_color(_x +_r*dcos(_a), _y +_r*dsin(_a), _color, 1);    _a -= 15;}
        draw_primitive_end();
        exit;
    }

    // Outline with 0 width
    if (_width <= 0) {
        draw_primitive_begin(pr_linestrip);
        var _a = 360;
        repeat (360/15 +1) {draw_vertex_color(_x +_r*dcos(_a), _y +_r*dsin(_a), _color, 1);    _a -= 15;}
        draw_primitive_end();
        exit;
    }

    // Outline with width
    var _ro    = _r +_width/2;
    var _ri    = _r -_width/2;
    draw_primitive_begin(pr_trianglestrip);
    var _a = 360;
    repeat (360/15 +1) {
        var _cos    = dcos(_a);
        var _sin    = dsin(_a);
        draw_vertex_color(_x +_ro*_cos, _y +_ro*_sin, _color, 1);
        draw_vertex_color(_x +_ri*_cos, _y +_ri*_sin, _color, 1);
        _a -= 15;
    }
    draw_primitive_end();
}