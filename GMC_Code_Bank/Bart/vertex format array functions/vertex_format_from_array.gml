function vertex_format_from_array(_arr_format) {
    vertex_format_begin();
    array_foreach(_arr_format, script_execute);
    return vertex_format_end();
}