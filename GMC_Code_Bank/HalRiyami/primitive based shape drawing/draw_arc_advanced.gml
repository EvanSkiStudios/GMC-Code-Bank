///    @func                draw_arc_advanced()
///    @param    {real}        x            The x coordinate of the center of the arc.
///    @param    {real}        y            The y coordinate of the center of the arc.
///    @param    {real}        r            The arc's radius (length from its center to its edge).
///    @param    {real}        angle        The starting angle in degrees.
///    @param    {real}        span        The arc's span in degrees.
///    @param    {integer}    width        The width in pixels of the arc.
///    @param    {integer}    color        The color of the arc.
function draw_arc_advanced(_x, _y, _r, _angle, _span, _width, _color) {
    var _increment    = 15*sign(_span);
    var _traversal    = 0;

    // Zero width case
    if (_width <= 0) {
        draw_primitive_begin(pr_linestrip);
        // Draw vertices up to the last one
        while (abs(_traversal) < abs(_span)) {
            var _dcos    = dcos(_angle +_traversal);
            var _dsin    = dsin(_angle +_traversal);
            draw_vertex_color(_x +_r*_dcos, _y -_r*_dsin, _color, 1);
            _traversal += _increment;
        }
        // Draw last vertex
        var _dcos    = dcos(_angle +_span);
        var _dsin    = dsin(_angle +_span);
        draw_vertex_color(_x +_r*_dcos, _y -_r*_dsin, _color, 1);
        draw_primitive_end();
        exit;
    }
    // Default case
    var _ro    = _r +_width/2;
    var _ri    = _r -_width/2;
    draw_primitive_begin(pr_trianglestrip);
    // Draw vertices up to the last one
    while (abs(_traversal) < abs(_span)) {
        var _dcos    = dcos(_angle +_traversal);
        var _dsin    = dsin(_angle +_traversal);
        draw_vertex_color(_x +_ro*_dcos, _y -_ro*_dsin, _color, 1);
        draw_vertex_color(_x +_ri*_dcos, _y -_ri*_dsin, _color, 1);
        _traversal += _increment;
    }
    // Draw last vertex
    var _dcos    = dcos(_angle +_span);
    var _dsin    = dsin(_angle +_span);
    draw_vertex_color(_x +_ro*_dcos, _y -_ro*_dsin, _color, 1);
    draw_vertex_color(_x +_ri*_dcos, _y -_ri*_dsin, _color, 1);
    draw_primitive_end();
}