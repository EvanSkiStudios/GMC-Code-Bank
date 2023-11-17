function draw_rectangle_patched(x1, y1, x2, y2, outline) {
  left   = x1;
  top    = y1;
  width  = x2 - x1;
  height = y2 - y1;
  if (!outline) {
    draw_sprite_stretched_ext(spr_DrawRectFix, 0, left, top, width, height, draw_get_color(), draw_get_alpha());
  } else {
    draw_sprite_stretched_ext(spr_DrawRectFix, 0, left - 2, top - 2, width + 2, 2, draw_get_color(), draw_get_alpha());
    draw_sprite_stretched_ext(spr_DrawRectFix, 0, left - 2, top - 2, 2, height + 2, draw_get_color(), draw_get_alpha());
    draw_sprite_stretched_ext(spr_DrawRectFix, 0, left + width, top, 2, height + 2, draw_get_color(), draw_get_alpha());
    draw_sprite_stretched_ext(spr_DrawRectFix, 0, left, top + height, width + 2, 2, draw_get_color(), draw_get_alpha());
  }
}