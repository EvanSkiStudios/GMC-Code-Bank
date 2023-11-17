function vertex_format_size(format) {
    static buff = buffer_create(256, buffer_fixed, 1);   // Fairly arbitrary size, static so we don't have to recreate every time
    var vb = vertex_create_buffer_from_buffer_ext(
        buff, format, 0, 1                               // A single vertex takes up the number of bytes of the format
    );
    var size = vertex_get_buffer_size(vb);               // How many bytes did we get?
    vertex_delete_buffer(vb);
    return size;
}