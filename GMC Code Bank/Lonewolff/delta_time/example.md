Running your game locked at any refresh rate. Do with this as you will. :)

```gml
// Create event

room_speed = 9999;
display_reset(0, true);
```

```gml
// Step event

var dt = detla_time / 1000000;
var move_speed = 100;         // 100 pixels per second

x += move_speed * dt;
```

Simple and to the point. The object moves at exactly 100 pixels per second on any monitor, regardless of refresh rate.

Users of 60 hz monitors get 60 FPS, users of 200 hz monitors get the benefit of ultra smooth 200 FPS. No tearing. Everyone's a winner! :D