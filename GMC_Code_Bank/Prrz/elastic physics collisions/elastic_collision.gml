function elastic_collision(_m1, _m2, _x1, _y1, _x2, _y2, _other) {
  
    // <i, j> (x/y) 'vectors'
    var _nx = abs(_x2 - _x1); // Difference between x terms (normalized)
    var _ny = abs(_y2 - _y1); // Difference between y terms (normalized)
  
    var _unx = _nx / sqrt(sq(_nx) + sq(_ny)); // x-unit normal vector
    var _uny = _ny / sqrt(sq(_nx) + sq(_ny)); // y-unit normal vector
  
    var _utx = -_uny; // x-unit tangent vector
    var _uty = _unx; // y-unit tanget vector

    var _v1n = dot_product(_unx, _uny, speed, speed); // projection of velocity for first object onto unit normal vectors
    var _v1t = dot_product(_utx, _uty, speed, speed); // projection of velocity for first object onto unit tangent vectors
    var _v2n = dot_product(_unx, _uny, _other.speed, _other.speed); // projection of velocity for 2nd object onto unit normal vectors
    var _v2t = dot_product(_utx, _uty, _other.speed, _other.speed); // projection of velocity for 2nd object onto unit tangent vectors
  
    var _v1tp = _v1t; // Tangent velocities do not change after collision
    var _v2tp = _v2t; //
  
    // --- One Dimensional Collision Formulas --- //
    var _v1np = (_v1n * (_m1 - _m2) + 2 * _m2 * _v2n) / (_m1 + _m2); // normal velocity for 1st object
    var _v2np = (_v2n * (_m2 - _m1) + 2 * _m1 * _v1n) / (_m1 + _m2); // normal velocity for 2nd object
  
    // --- Convert scalar normal and tangential velocities to 'vectors'
    var _fnx1 = _v1np * _unx;
    var _fny1 = _v1np * _uny;
    var _fnx2 = _v2np * _unx;
    var _fny2 = _v2np * _uny;
  
    var _ftx1 = _v1tp * _utx;
    var _fty1 = _v1tp * _uty;
    var _ftx2 = _v2tp * _utx;
    var _fty2 = _v2tp * _uty;
  
    // --- Add normal and tangential velocities together to calculate final velocities --- //
    var _fv1x = _fnx1 + _ftx1;
    var _fv1y = _fny1 + _fty1;
    var _fv2x = _fnx2 + _ftx2;
    var _fv2y = _fny2 + _fty2;
  
    // --- Find direction of impact for both objects --- //
    var dir_2 = point_direction(_x1, _y1, _x2, _y2);
    var dir_1 = point_direction(_x2, _y2, _x1, _y1);
  
    // --- Move collided instance out of the way --- //
    x += lengthdir_x(_fv1x, dir_1);
    y += lengthdir_y(_fv1y, dir_1);
    direction = dir_1; // Set direction of collided instance
  
  
    // --- Same thing but for the colliding instance 'other' --- //
    with(_other) {
        x += lengthdir_x(_fv2x, dir_2);
        y += lengthdir_y(_fv2y, dir_2);
        direction = dir_2;
    }
  
    if(_m2 >= _m1) { // _m2 is the mass of the colliding instance, 'other'.
        speed = abs(_fv1x + _fv1y) / sqrt(abs(_fv1x + _fv1y)); // Set the speed of the collided instance
        _other.speed = abs(_fv2x + _fv2y) / sqrt(abs(_fv2x + _fv2y)); // Set the speed of the colliding instance
        _other.speed *= (_m1 / _m2); // Scale larger objects speed by the ratio of the masses
    }
}


function sq(_val) {
    return(_val * _val); 
}