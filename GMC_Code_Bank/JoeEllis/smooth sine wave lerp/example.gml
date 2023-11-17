Here's a simple function I worked out recently, basically a smooth sine wave lerp.
It produces the same (or very similar) result as glsl's smoothstep function, and is done using lengthdir_y and captures the circular curve it produces.

Here are the functions in concise form:  
```gml
function sine_lerp(v1, v2, r)
{return lerp(v1, v2, (lengthdir_y(1, 90 + (r * 180)) + 1) * 0.5)}

function ratio_to_sine(r)
{return (lengthdir_y(1, 90 + (r * 180)) + 1) * 0.5}
```

I'm using this function with my soft brush falloff, it has a really nice effect!

Oh, I almost forgot! Visual results comparison: (Approximately)
![](https://i.ibb.co/JcPDMC7/Lerp-Sirp-Compariso.png)