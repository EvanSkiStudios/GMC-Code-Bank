Here's a very simple but useful function using angle_difference
If you've ever tried to lerp an angle, you'll know it has big problems on it's own cus of it wrapping around 0-360
This function makes an angle lerp in the same way as a normal number
and it doesn't matter if the input values are negative\positive, it simply lerps towards the actual direction. Perfect for smoothing turning and rotations.

```gml
angle_lerp(val1, val2, amount)
```

example usage:
```gml
//Turning towards an object

target_angle = point_direction(x, y, obj.x, obj.y)
angle = angle_lerp(angle, target_angle, 0.2)

//Smoothing turning (in a topdown game)

turn_speed = pi
turn_smooth = 0.1

input_h = keyboard_check(vk_left) - keyboard_check(vk_right)

target_angle += input_h * turn_speed

angle = angle_lerp(angle, target_angle, turn_smooth)
```
