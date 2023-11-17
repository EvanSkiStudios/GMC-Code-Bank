function color_conv_hex_rgb(hex=000000){
    /// @function color_conv_hex_rgb(hex)
    /// @desc returns the input hex color to an RGB color
    /// @param {real} hex code of input color
    
    var R = color_get_red(hex);
    var G = color_get_green(hex);
    var B = color_get_blue(hex);
    
    return( make_color_rgb(R,G,B) );
}