function lerp_smooth(val1, val2, amount)
{

var diff = round(val2 - val1);

return round(val1 + round(diff * amount))

}