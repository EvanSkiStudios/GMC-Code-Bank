/// @func UnionFindDisjointSet
/// @desc A Union-Find Disjoint Set implementation
function UnionFindDisjointSet(size) constructor {
  var _set, _rank;
  _rank = array_create(size, 0);
  _set = array_create(size);
  for (var i = 0; i < size; i++) {
    _set[i] = i;
  }

  static find = function(element) {
    if (_set[element] != element && _set[_set[element]] != _set[element]) {
      _set[element] = find(_set[element])
    }
    return _set[element];
  }

  static union = function(e1, e2) {
    e1 = find(e1);
    e2 = find(e2);
    switch (sign(_rank[e1] - _rank[e2])) {
      case 0:
        _rank[e1] += 1;
      case 1:
        _set[e2] = e1;
        break;
      case -1:
        _set[e1] = e2;
    }
  }
}