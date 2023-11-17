///@arg x
///@arg y
///@arg obj
/*
    - Obtains the instance ID of the object with the lowest depth
    among objects stacked on top of each other in a given collision
    point
*/
function instance_top(argument0,argument1,argument2) {
    var _xx = argument0;
    var _yy = argument1;
    var _obj = argument2;
    var _id = noone;
    
    //Get the instance with the lowest depth
    var target_list = ds_list_create();
    var target_num = collision_point_list(_xx,_yy,_obj,true,true,target_list,true);
    if target_num > 0 {
        var target_depth = 9999;//Can be any number greater than or equal to the object with the highest depth among all object assets
        for(var i=0;i<target_num;i++) {
            var target_obj = target_list[| i];
            if target_obj.depth < target_depth {
                target_depth = target_obj.depth;
                _id = target_obj;
            }
        }
    }
    ds_list_destroy(target_list);
    
    return _id;
}