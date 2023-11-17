function color_conv_hex_hsv_array(hex=000000){
    /// @function color_conv_hex_hsv_array(hex)
    /// @desc returns the input hex color to an HSV color in an array
    /// @param {real} hex code of input color
    
    var H = color_get_hue(hex);
    var S = color_get_saturation(hex);
    var V = color_get_value(hex);
    
    return( [H,S,V] );
}