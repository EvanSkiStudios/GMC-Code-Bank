function color_conv_hex_rgb_array(hex=000000){
    /// @function color_conv_hex_rgb_array(hex)
    /// @desc returns the input hex color to an RGB color in an array
    /// @param {real} hex code of input color
    
    var R = color_get_red(hex);
    var G = color_get_green(hex);
    var B = color_get_blue(hex);
    
    return( [R,G,B] );
}