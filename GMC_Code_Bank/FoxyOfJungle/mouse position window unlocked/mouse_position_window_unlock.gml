function window_mouse_x() {
    return display_mouse_get_x() - window_get_x();
}

function window_mouse_y() {
    return display_mouse_get_y() - window_get_y();
}