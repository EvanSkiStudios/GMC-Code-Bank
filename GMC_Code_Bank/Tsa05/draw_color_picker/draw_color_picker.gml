/// @description        draw_color_picker(x,y,w,h, ds_list)
/// @param    {real}    x            Starting x-coordinate
/// @param    {real}    y            Starting y-coordinate
/// @param    {real}    w            Width of picker
/// @param    {real}    h            Height of picker
/// @param    {real}    perRow        How many per row to draw
/// @param    {real}    colorsList    A ds_list containing [r,g,b] data
/*
*    Draw a series of bordered boxes using a defined border color and
*    a ds_list of Game Maker color values
*
*    Returns:
*        Real: An array of RGB color values
*/
var hilightColor = c_yellow;
var borderColor = c_black;

var px = argument[0];
var py = argument[1];
var pw = argument[2];
var ph = argument[3];
var pr = argument[4];
var pc = argument[5];

if(!ds_exists(pc,ds_type_list)) return -1;
var pn = ds_list_size(pc);
var preColor = draw_get_color();
// How small is a side, to make it all fit...
var p = 3;
var s = pw/pr-p;
var retVal = -1;
var dx = px; var dy = py;
for(var z = 0; z< pn; z+=1){
    draw_set_color(borderColor);
    if(point_in_rectangle(mouse_x,mouse_y, dx, dy, dx+s, dy+s)){
        retVal = pc[|z];
        draw_set_color(hilightColor);
    }
    draw_rectangle(dx, dy, dx+s, dy+s, 0);
    var c = pc[|z];
    if(is_array(c) && array_length_1d(c)>=3){
        draw_set_color(make_color_rgb(c[0], c[1], c[2]));
    }
    draw_rectangle(dx+1, dy+1, dx+s-1, dy+s-1, 0);
    dx+=s+p;
    if(dx>=px+pw){
        dx = px; dy+=s+p;
    }
}
draw_set_color(preColor);
return retVal;