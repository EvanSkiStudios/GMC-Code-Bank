///@func sprite_add_datauri(datauri, imgnumb, removeback, smooth, xorig, yorig)
///@arg datauri
///@arg imgnumb
///@arg removeback
///@arg smooth
///@arg xorig
///@arg yorig
///@desc Add sprite from Data URI
function sprite_add_datauri(datauri, imgnumb, removeback, smooth, xorig, yorig) {
    var result;
    if (os_browser != browser_not_a_browser) {
        result = sprite_add(datauri, imgnumb, removeback, smooth, xorig, yorig);
    } else {
        var posFirstSlash = string_pos("/", datauri);
        var posFirstSemicolon = string_pos(";", datauri);
        var extension = string_copy(datauri, posFirstSlash+1, posFirstSemicolon-posFirstSlash-1);
        var bufferBase64 = string_delete(datauri, 1, string_pos("base64,", datauri)+6);
        var buffer = buffer_base64_decode(bufferBase64);
        var filepath = working_directory + "temp" + sha1_string_unicode(string(date_current_datetime())) + "." + extension;
        buffer_save(buffer, filepath);
        buffer_delete(buffer);
        result = sprite_add(filepath, imgnumb, removeback, smooth, xorig, yorig);
        file_delete(filepath);
    }
    return result;
}