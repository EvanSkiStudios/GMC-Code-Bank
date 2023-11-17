function color_conv_rgb_hsv(RGB_color){
    /// @function color_conv_rgb_hsv
    /// @desc returns the input rgb color to an hsv
    /// @param {real} rgb of input color
    
    var H = color_get_hue(RGB_color);
    var S = color_get_saturation(RGB_color);
    var V = color_get_value(RGB_color);
    
    return( make_color_hsv(H,S,V) );
}