/// @func move_aabb
/// @param x
/// @param y
/// @param width
/// @param height
/// @param dx
/// @param dy

var dx = argument4, dy = argument5;

if (abs(dx) > abs(dy)) {
  dx = _move_aabb_horizontal(argument0, argument1, argument2, argument3, argument4);
  dy = _move_aabb_vertical(argument0, argument1, argument2, argument3, argument5);
} else {
  dy = _move_aabb_vertical(argument0, argument1, argument2, argument3, argument5);
  dx = _move_aabb_horizontal(argument0, argument1, argument2, argument3, argument4);
}

return [dx, dy];

/// @func _move_aabb_horizontal
/// @param x
/// @param y
/// @param width
/// @param height
/// @param dx

if (argument4 == 0) {
  return 0;
}

var _bbleft, _bbright, _bbtop, _bbbottom, bbleft, bbright, bbtop, bbbottom, dx;
dx = argument4;
var involved_aabbs = aabb_intersecting_rectangle(argument0 + min(0, dx), argument1, argument2 + dx, argument3);
bbleft = argument0;
bbright = argument0 + argument2;
bbtop = argument1;
bbbottom = argument1 + argument3;

var l = ds_list_size(involved_aabbs), inst;
for (var i = 0; i < l; i++) {
  inst = involved_aabbs[| i];
  _bbleft = inst.x;
  _bbtop = inst.y;
  _bbright = inst.x + inst.width;
  _bbbottom = inst.y + inst.height;
  if (rectangle_in_rectangle(bbleft, bbtop, bbright, bbbottom, _bbleft + margin, _bbtop + margin, _bbright - margin, _bbbottom - margin) == 0 &&
      rectangle_in_rectangle(bbleft + dx, bbtop, bbright + dx, bbbottom, _bbleft + margin, _bbtop + margin, _bbright - margin, _bbbottom - margin) != 0) {
    if (dx > 0) {
      dx = _bbleft - bbright;
    } else {
      dx = _bbright - bbleft;
    }
  }
}

ds_list_destroy(involved_aabbs);

return dx;

/// @func _move_aabb_vertical
/// @param x
/// @param y
/// @param width
/// @param height
/// @param dy

if (argument4 == 0) {
  return 0;
}

var _bbleft, _bbright, _bbtop, _bbbottom, bbleft, bbright, bbtop, bbbottom, dy;
dy = argument4;
var involved_aabbs = aabb_intersecting_rectangle(argument0, argument1 + min(0, dy), argument2, argument3 + dy);
bbleft = argument0;
bbright = argument0 + argument2;
bbtop = argument1;
bbbottom = argument1 + argument3;

var l = ds_list_size(involved_aabbs), inst;
for (var i = 0; i < l; i++) {
  inst = involved_aabbs[| i];
  _bbleft = inst.x;
  _bbtop = inst.y;
  _bbright = inst.x + inst.width;
  _bbbottom = inst.y + inst.height;
  if (rectangle_in_rectangle(bbleft, bbtop, bbright, bbbottom, _bbleft + margin, _bbtop + margin, _bbright - margin, _bbbottom - margin) == 0 &&
      rectangle_in_rectangle(bbleft, bbtop + dy, bbright, bbbottom + dy, _bbleft + margin, _bbtop + margin, _bbright - margin, _bbbottom - margin) != 0) {
    if (dy > 0) {
      dy = _bbtop - bbbottom;
    } else {
      dy = _bbbottom - bbtop;
    }
  }
}
return dy;

/// @func aabb_intersecting_rectangle
/// @param x
/// @param y
/// @param width
/// @param height

var l = ds_list_create();
collision_rectangle_list(argument0, argument1, argument0 + argument2, argument1 + argument3, AABB, false, false, l, false);
return l;