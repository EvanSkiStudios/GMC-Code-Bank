// Create event
room_speed = 9999;
display_reset(0, true);

// Step event
var dt = detla_time / 1000000;
var move_speed = 100;         // 100 pixels per second

x += move_speed * dt;