function color_conv_hex_hsv(hex=000000){
    /// @function color_conv_hex_hsv(hex)
    /// @desc returns the input hex color to an hsv color
    /// @param {real} hex code of input color
    
    var H = color_get_hue(hex);
    var S = color_get_saturation(hex);
    var V = color_get_value(hex);
    
    return( make_color_hsv(H,S,V) );
}
