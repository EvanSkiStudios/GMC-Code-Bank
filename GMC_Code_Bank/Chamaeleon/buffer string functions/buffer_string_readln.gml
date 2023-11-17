function buffer_string_readln(buf) {
    var start_pos = buffer_tell(buf);
    var end_pos = start_pos;
    var ch = buffer_peek(buf, end_pos, buffer_u8);
   
    while (end_pos < buffer_get_size(buf) && ch != ord("\n")) {
        ch = buffer_peek(buf, end_pos, buffer_u8);
        end_pos++;
    }
   
    buffer_copy(buf, start_pos, end_pos-start_pos, global.buffer_string_copy, 0);
    buffer_seek(buf, buffer_seek_start, end_pos);
    buffer_seek(global.buffer_string_copy, buffer_seek_start, end_pos-start_pos);
    buffer_write(global.buffer_string_copy, buffer_u8, 0);
    buffer_seek(global.buffer_string_copy, buffer_seek_start, 0);
    var result = buffer_read(global.buffer_string_copy, buffer_string);
    return result;
}