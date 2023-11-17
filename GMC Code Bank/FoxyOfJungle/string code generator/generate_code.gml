function generate_code(chars, size) {
    var _len = string_length(chars);
    var _strfinal = "";
    for (var i = 0; i < size; i+=1) {
        _strchars[i] = string_char_at(chars, irandom(_len));
        _strfinal += _strchars[i];
    }
    return string(_strfinal);
}