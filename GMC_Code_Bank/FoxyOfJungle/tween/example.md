Compact tween function that uses the animation curves of GMS 2.3:  

![](https://i.imgur.com/tMrOMup.png)  

```gml
// One
curvePosition = approach(curvePosition, 1, 0.02);
var _curveValue = tween(ac_tween_elastic, curvePosition, ["tweenIn"], 0);

// Two
curvePosition = approach(curvePosition, 1, 0.02);
var _curveValue = tween(ac_tween_elastic, curvePosition, ["tweenIn", "tweenOut"], 1);
```

Result:  
![](https://i.imgur.com/xrrzRhZ.gif)
