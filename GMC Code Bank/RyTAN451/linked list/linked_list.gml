/// @desc Linked List implementation
/// @func LinkedList()
function LinkedList() constructor {
  first = undefined;
  last = undefined;
  size = 0;
  _size = 0;
  static t_element = function(value, next, previous, ll) {
    v = value;
    n = next;
    p = previous;
    par = ll;
    static insertBefore = function(value) {
      var e = new t_element(value, self, p, par);
      if (!is_undefined(p)) p.n = e;
      else par.first = e;
      p = e;
      par._size += 1;
      par.size = _size;
    }
    static insertAfter = function(value) {
      var e = new t_element(value, n, self, par);
      if (is_undefined(n)) par.last = e;
      else n.p = e;
      n = e;
      par._size += 1;
      par.size = _size;
    }
    static destroy = function() {
      if (is_undefined(p)) par.first = n;
      else p.n = n;
      if (is_undefined(n)) par.last = p;
      else n.p = p;
      par._size -= 1;
      par.size = _size;
    }
  }
  static LLView = function(viewing) {
    _c = viewing;
    current = is_undefined(_c) ? undefined : _c.value;
    static previous = function() {
      if (is_undefined(_c) || is_undefined(_c.p)) {
        return false;
      } else {
        _c = _c.p;
        current = is_undefined(_c) ? undefined : _c.value;
        return true;
      }
    }
    static next = function() {
      if (is_undefined(_c) || is_undefined(_c.n)) {
        return false;
      } else {
        _c = _c.n;
        current = is_undefined(_c) ? undefined : _c.value;
        return true;
      }
    }
    static insertBefore = function(value) {
      if (!is_undefined(_c)) {
        _c.insertBefore(value);
      }
    }
    static insertAfter = function(value) {
      if (!is_undefined(_c)) {
        _c.insertAfter(value);
      }
    }
    static destroyBefore = function(value) {
      if (!is_undefined(_c) && !is_undefined(_c.p)) {
        var v = _c.p.value;
        _c.p.destroy();
        return v;
      }
      return undefined;
    }
    static destroyAfter = function(value) {
      if (!is_undefined(_c) && !is_undefined(_c.n)) {
        var v = _c.n.value;
        _c.n.destroy();
        return v;
      }
      return undefined;
    }
    static set = function(value) {
      if (!is_undefined(_c)) {
        _c.value = value;
      }
    }
    static destroy = function() {};
  }
  
  static empty = function() {
    return _size == 0;
  }
  static clear = function() {
    var s = _size;
    first = undefined;
    last = undefined;
    _size = 0;
    size = _size;
    return s;
  }
  static insertFirst = function(value) {
    var e = new t_element(value, first, undefined, self);
    if (!is_undefined(first)) {
      first.p = e;
    }
    if (is_undefined(last)) {
      last = e;
    }
    first = e;
    _size += 1;
    size = _size;
  }
  static insertLast = function(value) {
    var e = new t_element(value, undefined, last, self);
    if (!is_undefined(last)) {
      last.n = e;
    }
    if (is_undefined(first)) {
      first = e;
    }
    last = e;
    _size += 1;
    size = _size;
  }
  static deleteFirst = function() {
    if (is_undefined(first)) {
      return undefined;
    }
    var v = first.value;
    first = first.n;
    if (is_undefined(first)) {
      last = first;
    } else {
      first.p = undefined;
    }
    _size -= 1;
    size = _size;
    return v;
  }
  static deleteLast = function() {
    if (is_undefined(last)) {
      return undefined;
    }
    var v = last.value;
    last = last.p;
    if (is_undefined(last)) {
      first = last;
    } else {
      last.n = undefined;
    }
    _size -= 1;
    size = _size;
    return v;
  }
  static getViewFirst = function() {
    return new LLView(first);
  }
  static getViewLast = function() {
    return new LLView(last);
  }
  
  static destroy = function() {}
}