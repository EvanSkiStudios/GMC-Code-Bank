function print() {
    if (argument_count > 0) {
        var _log = "";
        for (var i = 0; i < argument_count; i++;) {
            _log += string(argument[i]);
            if (argument_count > 1) _log += " | ";
        }
        show_debug_message(_log);
    }
}