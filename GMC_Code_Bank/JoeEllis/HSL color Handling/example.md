Here are two functions for HSL color handling (hue, sat, lum)
I've always preferred color pickers that use lum instead of val, cus I find it awkward to create pastel colors with hue sat val. You have to adjust the sat and val separately and lum makes it a lot simpler. I generally just prefer the way it works cus it seems more logical and I'm used to it from using paint since I was little.

I got the original code from https://www.easyrgb.com/en/, which is a great resource for anything color related.

I can't actually explain what the maths is doing cus I don't understand it 100%, more like 65% lol
but it is explained on https://www.easyrgb.com/en/

So this is the function for creating a color using hsl: (It's basically the same as make_color_hsv, but with lum instead)
```make_color_hsl(hue, sat, lum)```

And this is the function for getting the hue, sat and lum values of a color (A standard gm color as the input argument)
```color_get_hsl(color)```