function draw_sprite_aspect(sprite, subimage, x, y, xscale, yscale, rot, col, alpha, areaw, areah) {
    var xsc, ysc;
    if (areaw != 0) {
        xsc = areaw / sprite_get_width(sprite) * xscale;
        ysc = xsc;
    } else {
        ysc = areah / sprite_get_height(sprite) * yscale;
        xsc = ysc;
    }
    draw_sprite_ext(sprite, subimage, x, y, xsc, ysc, rot, col, alpha);
}