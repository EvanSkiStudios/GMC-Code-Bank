/// @desc color_gradient(color_array, progress);
/// @param color_array
/// @param progress
/***************************************************
  HowToUse
    Interpolate through a gradient defined by
  an array of colors and percentile progress
  value;
 
  returns - color value
***************************************************/
var _arr = argument0,
    _max = array_length_1d(_arr)-1
    _prog = (argument1 mod 1) * _max;

return merge_color(_arr[floor(_prog)], _arr[ceil(_prog)], frac(_prog));