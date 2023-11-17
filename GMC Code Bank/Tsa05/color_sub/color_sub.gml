///    @arg    {string}    colorName        The name of the GMS color to use
///    @returns    {real}    colorVal        Game Maker encoded color or -1

var c = string_lower(argument[0]);

switch (c){
    case "aqua":
        return c_aqua;
    break;
    case "black":
        return c_black
    break;
    case "blue":
        return c_blue;
    break;
    case "dkgray":
        return c_dkgray;
    break;
    case "fuchsia":
        return c_fuchsia;
    break;
    case "gray":
        return c_gray;
    break;
    case "green":
        return c_green;
    break;
    case "lime":
        return c_lime;
    break;
    case "ltgray":
        return c_ltgray;
    break;
    case "maroon":
        return c_maroon;
    break;
    case "navy":
        return c_navy;
    break;
    case "olive":
        return c_olive
    break;
    case "orange":
        return c_orange
    break;
    case "purple":
        return c_purple
    break;
    case "red":
        return c_red;
    break;
    case "silver":
        return c_silver;
    break;
    case "teal":
        return c_teal;
    break;
    case "white":
        return c_white;
    break;
    case "yellow":
        return c_yellow;
    break;
}
return -1;