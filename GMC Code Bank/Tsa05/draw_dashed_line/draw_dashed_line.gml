///    @arg    x1            x1
///    @arg    y1            y1
///    @arg    x2            x2
///    @arg    y2            y2
///    @arg    width        Width of line
///    @arg    dashSize    Spacing/size of dash
///    @arg    dashType    Dashed or dotted
var x1 = argument0;
var y1 = argument1;
var x2 = argument2;
var y2 = argument3;
var w  = argument4;
var size = argument5;
var type = argument6;

var len = point_distance(x1,y1,x2,y2) div size;
var dir = point_direction(x1,y1,x2,y2);
var a = lengthdir_x(size,dir);
var b = lengthdir_y(size,dir);
for(var i=0; i<len; i++){
    if !(i & 1){
        if(type==0){
            draw_line_width(x1+a*i, y1+b*i, x1+a*(i+1), y1+b*(i+1), w);
        }else if(type==1){
            draw_circle(x1+a*i, y1+b*i, w, 0);
        }
    }
}