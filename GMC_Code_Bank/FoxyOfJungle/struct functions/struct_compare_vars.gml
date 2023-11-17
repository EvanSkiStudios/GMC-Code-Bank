// compare if a struct has variables and values equal to another
function struct_compare_vars(struct1, struct2) {
    var _s1 = json_stringify(struct1);
    var _s2 = json_stringify(struct2);
    var _equal = (_s1 == _s2) ? true : false;
    return _equal;
}