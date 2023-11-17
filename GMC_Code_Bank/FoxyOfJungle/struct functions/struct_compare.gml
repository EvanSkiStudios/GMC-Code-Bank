// compare if a struct has variables equal to another
function struct_compare(struct1, struct2) {
    var _equal = false;
    if is_struct(struct1) && is_struct(struct2) {
        var _names1 = variable_struct_get_names(struct1);
        var _names2 = variable_struct_get_names(struct2);
        var _size1 = array_length(_names1);
        var _size2 = array_length(_names2);
        var _total = (_size1+_size2);
        var _n = 0;
 
        for (var i = 0; i < _size1; ++i) {
            var _name1 = _names1[i];
            for (var j = 0; j < _size2; ++j) {
                var _name2 = _names2[i];
                if (_name1 == _name2) {
                    _n += 1;
                }
            }
        }
        if (_n >= _total) {
            _equal = true;
        }
    }
    return _equal;
}