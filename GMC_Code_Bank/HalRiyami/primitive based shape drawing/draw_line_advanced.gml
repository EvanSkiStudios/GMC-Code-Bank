///    @func                draw_line_advanced()
///    @param    {real}        x1            The x coordinate of the start of the line.
///    @param    {real}        y1            The y coordinate of the start of the line.
///    @param    {real}        x2            The x coordinate of the end of the line.
///    @param    {real}        y2            The y coordinate of the end of the line.
///    @param    {integer}    width        The width in pixels of the line.
///    @param    {integer}    color        The color of the line.
function draw_line_advanced(_x1, _y1, _x2, _y2, _width, _color) {
    // Zero width case
    if (_width <= 0) {
        draw_primitive_begin(pr_linestrip);
        draw_vertex_color(_x1, _y1, _color, 1);
        draw_vertex_color(_x2, _y2, _color, 1);
        draw_primitive_end();
        exit;
    }
    // Default case
    var _nX    = _y2 -_y1;
    var _nY    = _x1 -_x2;
    var _d    = sqrt(_nX*_nX +_nY*_nY);
    _nX        = _nX*_width/_d/2;
    _nY        = _nY*_width/_d/2;

    draw_primitive_begin(pr_trianglestrip);
    draw_vertex_color(_x1 +_nX, _y1 +_nY, _color, 1);
    draw_vertex_color(_x1 -_nX, _y1 -_nY, _color, 1);
    draw_vertex_color(_x2 +_nX, _y2 +_nY, _color, 1);
    draw_vertex_color(_x2 -_nX, _y2 -_nY, _color, 1);
    draw_primitive_end();
}