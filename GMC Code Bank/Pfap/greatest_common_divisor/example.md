```
gcd(a,b)
```

Here's a script for finding the greatest common divisor of two numbers.

I discovered the usefulness of this script while working out a way to display point meters. It could be useful for health bars or other in game bars; basically, anytime you want to display a fraction of a whole.

Lets say you have a level progress bar that takes 1000 points to fill and you want it to be displayed in the center of your room and for this example, the bar already has 500 points. The problem I ran into is that my room_width is 432 and I wanted 16 pixels of padding on either side.
So, we know that the full bar is 1000 points, which leaves us with 1 unkown that can be though of as a fraction algebra problem.
500/1000 and x/(room_width-32)

We need to reduce before we can divide and multiply to find x, which is what the above script will do for you.


Here is some code depicting a progress bar 1/2 full.

```gml
bar_progress = 500;
bar_length = 1000;


//reduce the current amount of bar_progress/bar_length
var divisor = gcd(bar_progress,bar_length);
var reduced_progress = bar_progress/divisor;
var reduced_bar = bar_length/divisor;

//now get it into the amounts I can use to draw
full_length = (room_width-32);//32 for padding
var multiplier = full_length/reduced_bar;
draw_progress = multiplier*reduced_progress;
```

Now draw progress will be the length of half of (room_width-32) or 200/400. Which is what I wanted a 200 pixel length bar to draw on top of a 400 pixel bar of a different color, thus depicting progress of 50%.
It is really easy to use any values to build dynamic meters and bars to display info and can of course be easily used with sprite_width for any custom bars or even set values and draw_line for simple enemy health bars that will not pollute the game screen. For instance, if you have enemy sprites that are 32 pixels wide and you want to cram a 1000 point health bar above them; you would just replace the full_length variable with a value you set, in this case 32.

I guess it could almost be thought of as a unit converter for points to pixels.





Commonly known as the Euclidean algorithm and the original script I discovered here:
https://forum.yoyogames.com/index.php?threads/greatest-common-factor-script.25245/