function color_conv_rgb_hsv_array(RGB_color){
    /// @function color_conv_rgb_hsv_array
    /// @desc returns the input rgb color to an hsv array
    /// @param {real} rgb  of input color
    
    var H = color_get_hue(RGB_color);
    var S = color_get_saturation(RGB_color);
    var V = color_get_value(RGB_color);
    
    return( [H,S,V] );
}