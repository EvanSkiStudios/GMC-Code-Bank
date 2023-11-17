/// @func stretched_to_fit_window
/// @param width
/// @param height
/// @param stretch_mode

enum Stretching {
  NONE,
  ASPECT,
  FULL
}

var width = argument0,
    height = argument1,
    window_width = window_get_width(),
    window_height = window_get_height();

switch (argument2) {
  case Stretching.NONE:
    return [(window_width - width) / 2, (window_height - height) / 2, width, height];
  case Stretching.ASPECT:
    var window_aspect_ratio = window_width/window_height,
        application_surface_aspect_ratio = width/height;
    var stretched_application_surface_width, stretched_application_surface_height;
    if (window_aspect_ratio < application_surface_aspect_ratio) {
      // Set heights to equal
      stretched_application_surface_height = window_height;
      stretched_application_surface_width = width * stretched_application_surface_height / height;
    } else if (window_aspect_ratio > application_surface_aspect_ratio) {
      // Set widths to equal
      stretched_application_surface_width = window_width;
      stretched_application_surface_height = height * stretched_application_surface_width / width;
    } else {
      // Stretch over whole
      stretched_application_surface_width = window_width;
      stretched_application_surface_height = window_height;
    }
    return [
      (window_width - stretched_application_surface_width) / 2, 
      (window_height - stretched_application_surface_height) / 2, 
      stretched_application_surface_width, stretched_application_surface_height];
  case Stretching.FULL:
    return [0, 0, window_width, window_height];
  }