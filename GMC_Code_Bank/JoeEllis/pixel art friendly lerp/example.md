I made a pixel art friendly version of lerp which reduces that jittery effect you often get when the camera moves smoothly with lerp:

```gml
lerp_smooth(val1, val2, amount)
```

I'm not sure if all of the rounds are necessary, I haven't tested it thoroughly yet, cus it seemed to work pretty well straight away

I think why it works\makes it look better with pixel games is cus it removes the subpixel part, and old sega games etc used integer math for everything, or they had much less precision, so they had to like make whole pixel movements spread across certain periods of time, which probably took a while to get right. It's something we take for granted now but there's a certain part that's lost in the "rift" between 16 bit and 32 bit.. I recommend to try and explore other time based integer movements (to go further into this realm)