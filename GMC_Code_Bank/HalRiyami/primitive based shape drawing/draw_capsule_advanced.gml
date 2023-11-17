///    @func                draw_capsule_advanced()
///    @param    {real}        x1            The x coordinate of the center of the start of the capsule.
///    @param    {real}        y1            The y coordinate of the center of the start of the capsule.
///    @param    {real}        x2            The x coordinate of the center of the end of the capsule.
///    @param    {real}        y2            The y coordinate of the center of the end of the capsule.
///    @param    {real}        r            The radius (distance from center to edge) of the capsule in pixels.
///    @param    {integer}    color        The color of the capsule.
///    @param    {boolean}    outline        Whether the capsule is drawn filled (false) or as an outline (true).
///    @param    {integer}    width        The width of the outline (in pixels). Ignored of filled.
function draw_capsule_advanced(_x1, _y1, _x2, _y2, _r, _color, _outline, _width) {
    // Normal vector
    var _d    = sqrt((_y2 -_y1)*(_y2 -_y1) +(_x1 -_x2)*(_x1 -_x2));
    var _vx    = (_y2 -_y1)/_d*_r;
    var _vy    = (_x1 -_x2)/_d*_r;
    var _a    = darctan2(_vy, _vx);

    // Filled case
    if (!_outline) {
        draw_primitive_begin(pr_trianglefan);
        draw_vertex_color((_x1 +_x2)/2, (_y1 +_y2)/2, _color, 1);
        repeat (180/15 +1) {draw_vertex_color(_x1 +_r*dcos(_a), _y1 +_r*dsin(_a), _color, 1);    _a -= 15;}
        _a    += 15;
        repeat (180/15 +1) {draw_vertex_color(_x2 +_r*dcos(_a), _y2 +_r*dsin(_a), _color, 1);    _a -= 15;}
        draw_vertex_color(_x1 +_vx, _y1 +_vy, _color, 1);
        draw_primitive_end();
        exit;
    }
    // Outline with 0 width
    if (_width <= 0) {
        draw_primitive_begin(pr_linestrip);
        repeat (180/15 +1) {draw_vertex_color(_x1 +_r*dcos(_a), _y1 +_r*dsin(_a), _color, 1);    _a -= 15;}
        _a    += 15;
        repeat (180/15 +1) {draw_vertex_color(_x2 +_r*dcos(_a), _y2 +_r*dsin(_a), _color, 1);    _a -= 15;}
        draw_vertex_color(_x1 +_vx, _y1 +_vy, _color, 1);
        draw_primitive_end();
        exit;
    }
    // Outline with width
    var _ro    = _r +_width/2;
    var _ri    = _r -_width/2;
    draw_primitive_begin(pr_trianglestrip);
    repeat (180/15 +1) {
        var _cos    = dcos(_a);
        var _sin    = dsin(_a);
        draw_vertex_color(_x1 +_ro*_cos, _y1 +_ro*_sin, _color, 1);
        draw_vertex_color(_x1 +_ri*_cos, _y1 +_ri*_sin, _color, 1);
        _a -= 15;
    }
    _a    += 15;
    repeat (180/15 +1) {
        var _cos    = dcos(_a);
        var _sin    = dsin(_a);
        draw_vertex_color(_x2 +_ro*_cos, _y2 +_ro*_sin, _color, 1);
        draw_vertex_color(_x2 +_ri*_cos, _y2 +_ri*_sin, _color, 1);
        _a -= 15;
    }
    draw_vertex_color(_x1 +_ro*_cos, _y1 +_ro*_sin, _color, 1);
    draw_vertex_color(_x1 +_ri*_cos, _y1 +_ri*_sin, _color, 1);
    draw_primitive_end();
}