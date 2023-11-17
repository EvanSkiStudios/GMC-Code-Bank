//Script for making an object follow the surface of a wall
//Written by TheSnidr, 2023
//Source 1: https://forum.gamemaker.io/index.php?threads/wall-crawling-zoomers.102847/post-620852
//Source 2: https://forum.gamemaker.io/index.php?threads/code-bank-share-useful-code.60575/post-620940

//Settings, could be placed in create event if you'd like, but also works perfectly fine in step event
spd = 2;                        //Positive to move to the right, negative to move to the left
radius = 8;                        //This is the distance to the probe we use to measure the angle of the wall
pixelsPerStep = 2;                //A value of 1 means pixel-perfect movement. A higher value means less precision and less processing.
angularStepSize = 3;            //The step size in the angle. A higher value means less precision and less processing.
angleDampening = .7;            //This softens the changes in image_angle
wallParent = obj_Parent_Solid;    //The object the wall-crawler collides with

//Start iteratin'
var w = sign(spd);
var l = radius * w;
var c =   dcos(direction);
var s = - dsin(direction);
var d = abs(spd) / pixelsPerStep;
repeat ceil(d)
{
    //Attach to walls
    repeat 4
    {
        var t = place_meeting(x, y, wallParent) * 2 - 1;
        x += s * t;
        y -= c * t;
        if t break;
    }
    if !t continue;

    //Adjust angle
    var p = 0;
    repeat 10
    {
        var t = place_meeting(x + l * c, y + l * s, wallParent) * 2 - 1;
        if (p > 0 && !t) break;
        direction += angularStepSize * w * t;
        c =   dcos(direction);
        s = - dsin(direction);
        if (p < 0 && t) break;
        p = t;
    }

    //Move along the surface of the wall
    var t = pixelsPerStep * w * min(d--, 1);
    x += c * t;
    y += s * t;
}
direction = (direction + 360) mod 360;
image_angle = (image_angle + angleDampening * angle_difference(direction, image_angle) + 360) mod 360;