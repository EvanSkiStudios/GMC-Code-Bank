function buffer_check_pos(buf, pos, substr) {
    buffer_copy(buf, pos, string_length(substr), global.buffer_string_copy, 0);
    buffer_seek(global.buffer_string_copy, buffer_seek_start, string_length(substr));
    buffer_write(global.buffer_string_copy, buffer_u8, 0);
    buffer_seek(global.buffer_string_copy, buffer_seek_start, 0);
    var buf_substr = buffer_read(global.buffer_string_copy, buffer_string);
    return substr == buf_substr;
}