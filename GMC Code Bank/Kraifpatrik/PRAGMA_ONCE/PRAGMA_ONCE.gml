#macro PRAGMA_ONCE \
    do \
    { \
        if (!variable_global_exists("__pragmaOnce")) \
        { \
            global.__pragmaOnce = ds_map_create(); \
        } \
        var _cs = debug_get_callstack(); \
        var _cr = _cs[0]; \
        if (ds_map_exists(global.__pragmaOnce, _cr)) \
        { \
            exit; \
        } \
        global.__pragmaOnce[? _cr] = 1; \
    } \
    until (1)