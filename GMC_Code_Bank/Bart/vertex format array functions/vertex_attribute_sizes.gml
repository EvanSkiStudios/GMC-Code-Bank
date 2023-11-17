function vertex_attribute_sizes(_arr_format) {
    static buff = buffer_create(256, buffer_fixed, 1);      // Fairly arbitrary size, static so we don't have to recreate every time
    var _len = array_length(_arr_format);
    var _arr_sizes = array_create(_len);
    for(var _i = 0; _i < _len;_i++) {
        vertex_format_begin(); _arr_format[_i]();
        var _fmt = vertex_format_end();
        var _vb = vertex_create_buffer_from_buffer_ext(
            buff, _fmt, 0, 1                                // A single vertex takes up the number of bytes of the format
        );
        _arr_sizes[_i] = vertex_get_buffer_size(_vb);       // How many bytes did we get?
        vertex_format_delete(_fmt);
        vertex_delete_buffer(_vb);
    }
    return _arr_sizes;
}