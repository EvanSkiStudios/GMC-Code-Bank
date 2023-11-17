
function buffer_find_substr(buf, substr) {
    var buf_size = buffer_get_size(buf);
    var pos = buffer_tell(buf);
    while (pos < buf_size) {
        if (buffer_check_pos(buf, pos, substr)) {
            buffer_seek(buf, buffer_seek_start, pos);
            return true;
        }
        pos++;
    }
    return false;
}