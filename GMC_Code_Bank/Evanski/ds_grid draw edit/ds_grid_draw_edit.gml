function ds_grid_draw(grid,sx,sy) {
//
//  Draws the data of a given grid at a screen location.
//
//      grid        grid data structure, id
//      x,y         screen position, real
//
// GMLscripts.com/license
    var w = ds_grid_width(grid);
    var h = ds_grid_height(grid);

    var M = ds_grid_get_max(grid,0,0,w-1,h-1);
    var m = ds_grid_get_min(grid,0,0,w-1,h-1);
    if (M == m) var f = 0 else var f = 1/(M-m);

    for (var i=0; i<w; i++)
    {
        for (var j=0; j<h; j++)
        {

            var value = (ds_grid_get(grid,i,j));
            if (value == -1)
            {
                value = 1;
                draw_text_color(sx+i*20,sy+j*20,string(value),c_red,c_red,c_red,c_red,1);
            }else{
                value = 0;
                draw_text_color(sx+i*20,sy+j*20,string(value),c_lime,c_lime,c_lime,c_lime,1);
            }
         
        }
    }

    return 0;
}