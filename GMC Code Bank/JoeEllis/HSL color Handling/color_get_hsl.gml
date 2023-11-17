function color_get_hsl(color) {

//Gets the hue, sat and lum of a given color (standard gm color value)
//and returns them in a vec3 array
//Note: the output ranges are: hue(0 - 1530), sat(0 - 255), lum(0 - 510)

    var
    r = colour_get_red(color) / 255,
    g = colour_get_green(color) / 255,
    b = colour_get_blue(color) / 255,
    _min, _max, _range, hue, sat, lum;

    _min = min(r, g, b)
    _max = max(r, g, b)
    _range = _max - _min

    lum = (_max + _min) / 2

    if _range = 0
    {
    hue = 0
    sat = 0
    }
    else
    {

    if lum < 0.5
    {sat = _range / (_max + _min)}
    else
    {sat = _range / (2 - _max - _min)}

    if r = _max
    {
    if g > b
    {hue = (g - b) / _range}
    else
    {hue = 6 - ((b - g) / _range)}
    }
    else
    {
    if g = _max
    {hue = 2 + (b - r) / _range}
    else
    {hue = 4 + (r - g) / _range}
    }
    if h < 0
    {++hue}
    if h > 6
    {--hue}
    }

    return [round(hue * 1530), round(sat * 255), round(lum * 510)]
}