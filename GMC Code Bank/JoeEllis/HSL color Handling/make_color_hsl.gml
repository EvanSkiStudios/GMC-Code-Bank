function make_color_hsl(hue, sat, lum) {

//Same as make_color_hsv only it uses lum instead of val (Like the ms paint color picker)
//and returns a standard gm color value (u32 integer)
//Note: the input ranges are: hue(0 - 1530), sat(0 - 255), lum(0 - 510)
//This means you're able to use all 1530 possible hues instead of just 255 like make_color_hsv

    //Convert input values to 0-1 range
    hue /= 1530
    sat /= 255
    lum /= 510

    var
    r = hue + 0.333,
    g = hue,
    b = hue - 0.333,
    v1, v2, _range;
  
    if lum < 0.5
    {v1 = lum * (1.0 + sat)}
    else
    {v1 = lum + sat - lum * sat}

    v2 = 2 * lum - v1

    _range = v1 - v2

    //Wrap rgb values to 0-1 range
    if r > 1
    || r < 0
    {r -= sign(r)}
  
    if g > 1
    || g < 0
    {g -= sign(g)}
  
    if b > 1
    || b < 0
    {b -= sign(b)}

    //Red
    if 6 * r < 1
    {r = v2 + _range * 6 * r}
    else
    {
    if 2 * r < 1
    {r = v1}
    else
    {
    if 3 * r < 2
    {r = v2 + _range * (0.666 - r) * 6}
    else
    {r = v2}
    }
    }

    //Green
    if 6 * g < 1
    {g = v2 + _range * 6 * g}
    else
    {
    if 2 * g < 1
    {g = v1}
    else
    {
    if 3 * g < 2
    {g = v2 + _range * (0.666 - g) * 6}
    else
    {g = v2}
    }
    }

    //Blue
    if 6 * b < 1
    {b = v2 + _range * 6 * b}
    else
    {
    if 2 * b < 1
    {b = v1}
    else
    {
    if 3 * b < 2
    {b = v2 + _range * (0.666 - b) * 6}
    else
    {b = v2}
    }
    }

    return make_color_rgb(r * 255, g * 255, b * 255)
}

