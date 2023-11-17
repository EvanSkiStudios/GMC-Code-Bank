///    @func                draw_rectangle_advanced()
///    @param    {real}        x1            The x coordinate of the left of the rectangle.
///    @param    {real}        y1            The y coordinate of the top of the rectangle.
///    @param    {real}        x2            The x coordinate of the right of the rectangle.
///    @param    {real}        y2            The y coordinate of the bottom of the rectangle.
///    @param    {integer}    color        The color of the rectangle.
///    @param    {boolean}    outline        Whether the rectangle is drawn filled (false) or as an outline (true).
///    @param    {integer}    width        The width of the outline in pixels. Ignored of filled.
function draw_rectangle_advanced(_x1, _y1, _x2, _y2, _color, _outline, _width) {
    // Filled case
    if (!_outline) {
        draw_primitive_begin(pr_trianglestrip);
        draw_vertex_color(_x1, _y1, _color, 1);
        draw_vertex_color(_x2, _y1, _color, 1);
        draw_vertex_color(_x1, _y2, _color, 1);
        draw_vertex_color(_x2, _y2, _color, 1);
        draw_primitive_end();
        exit;
    }
    // Outline with 0 width
    if (_width <= 0) {
        draw_primitive_begin(pr_linestrip);
        draw_vertex_color(_x1, _y1, _color, 1);
        draw_vertex_color(_x2, _y1, _color, 1);
        draw_vertex_color(_x2, _y2, _color, 1);
        draw_vertex_color(_x1, _y2, _color, 1);
        draw_vertex_color(_x1, _y1, _color, 1);
        draw_primitive_end();
        exit;
    }
    // Outline with width
    _width /= 2;
    draw_primitive_begin(pr_trianglestrip);
    // Top left corner
    draw_vertex_color(_x1 -_width, _y1 -_width, _color, 1);
    draw_vertex_color(_x1 +_width, _y1 +_width, _color, 1);
    // Top right corner
    draw_vertex_color(_x2 +_width, _y1 -_width, _color, 1);
    draw_vertex_color(_x2 -_width, _y1 +_width, _color, 1);
    // Bottom right corner
    draw_vertex_color(_x2 +_width, _y2 +_width, _color, 1);
    draw_vertex_color(_x2 -_width, _y2 -_width, _color, 1);
    // Bottom left corner
    draw_vertex_color(_x1 -_width, _y2 +_width, _color, 1);
    draw_vertex_color(_x1 +_width, _y2 -_width, _color, 1);
    // Top left corner
    draw_vertex_color(_x1 -_width, _y1 -_width, _color, 1);
    draw_vertex_color(_x1 +_width, _y1 +_width, _color, 1);
    draw_primitive_end();
}