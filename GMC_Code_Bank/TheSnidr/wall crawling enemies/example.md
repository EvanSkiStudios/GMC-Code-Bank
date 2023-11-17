Made a script for wall-crawling enemies which could be useful to others! See this topic for background info: https://forum.gamemaker.io/index.php?threads/wall-crawling-zoomers.102847/  
![](https://dl.dropboxusercontent.com/s/dbd787kg3d5ps22/WallCrawler4.gif?dl=0)

EDIT:
And here's a slightly shorter and sweeter version that makes use of speed and direction rather than manually moving the object pixel by pixel:

```gml
//Script for making an object follow the surface of a wall
//Written by TheSnidr, 2023
//Source 1: https://forum.gamemaker.io/index.php?threads/wall-crawling-zoomers.102847/post-620852
//Source 2: https://forum.gamemaker.io/index.php?threads/code-bank-share-useful-code.60575/post-620940
//Settings, could be placed in create event if you'd like, but also works perfectly fine in step event
wallcrawler_speed = -3;                        //Positive to move to the right, negative to move to the left
wallcrawler_radius = 8;                        //This is the distance to the probe we use to measure the angle of the wall
wallcrawler_angleDamping = .7;                //This softens the changes in image_angle
wallcrawler_angularStepNum = 10;            //Number of iterations allowed when adjusting the angle
wallcrawler_angularStepSize = 4.5;            //The step size in the angle. A higher value means less processing, but less precision. Preferably a divisor of 45.
wallcrawler_wallParent = obj_Parent_Solid;    //The object the wall-crawler collides with

//Attach to walls, place in step event
for (var i = 0, p = 0; ++i <= 5 && !p; p = speed)
{    //This loop makes sure the object stays attached to the wall by moving it vertically until it finds a collision
    speed = place_meeting(x, y, wallcrawler_wallParent) * 2 - 1; //It uses speed as an alternative to manually doing trig. Speed is 1 or -1 depending on wether there was a collision.
    x += vspeed; //We want to move vertically compared to direction. Instead of changing the direction, we can swap the axes and change the sign of one of them to rotate 90 degrees.
    y -= hspeed;
}
if (++speed) //This line both checks the value of speed (which is 1 if there is a collision), and sets it to 0 if there was no collision.
{
    speed = wallcrawler_radius * sign(wallcrawler_speed); //Another abuse of speed instead of manually doing trig
    for (var i = 0, p = 0; ++i <= wallcrawler_angularStepNum && p < 2; p = (p == -t) ? 2 : t)
    {    //For loop abuse. We want to end the loop if the previous step had no collision and this step does, or vice versa.
        var t = place_meeting(x + hspeed, y + vspeed, wallcrawler_wallParent) * 2 - 1;
        direction += wallcrawler_angularStepSize * sign(wallcrawler_speed) * t * (p <= 0 || t);
    }
    speed = wallcrawler_speed; //We're done abusing speed for trig, this is the actual speed we want the object to have.
}
direction = (direction + 360) mod 360; //Make sure direction is within the range [0, 360]
image_angle = (image_angle + wallcrawler_angleDamping * angle_difference(direction, image_angle) + 360) mod 360; //Smoothly interpolate image_angle towards direction
```