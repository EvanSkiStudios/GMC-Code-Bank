Simple sine wave floating motion that you can add to any object

Call float_init() in an object's create event and float_step() in the step event

It works with objects with other movement aswell cus of the part where it subtracts the previous float movement (float_y), so it makes it accurately float around it's current position