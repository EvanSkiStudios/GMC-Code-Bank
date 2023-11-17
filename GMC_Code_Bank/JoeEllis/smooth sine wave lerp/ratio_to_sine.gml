function ratio_to_sine(r) // "r" should be a value between 1 and 0
{

//Convert input into an angle (the range is 180 degrees)
var angle = r * 180;

//Add 90 degrees onto the angle to make it start at 90 and end at 270
angle += 90;

//If you picture it in your head, this means it starts at fully at the top, and ends fully at the bottom.
//This is the range of values we need. Basically, with a length of 1, it'll return between -1 (top) to 1 (bottom)

var value = lengthdir_y(1, angle);

//Then to convert this output range into 0 - 1 range, we just need to add 1, which will make -1 = 0, and 1 = 2.

value += 1;

//Then to reduce the range from 0 - 2, to 0 - 1, we just need to divide it by 2.

value *= 0.5;

//Then we have the value. The input value has been transformed (bended) into a sine wave!

return value;

}