function draw_setup(color = undefined, alpha = undefined, font = undefined, halign = undefined, valign = undefined) {
    draw_set_color(color ?? draw_get_color());
    draw_set_alpha(alpha ?? draw_get_alpha());
    draw_set_font(font ?? draw_get_font());
    draw_set_halign(halign ?? draw_get_halign());
    draw_set_valign(valign ?? draw_get_valign());
}