function instance_top_position(mx, my, object)
{
    /// @func instance_top_position(mx, my, object)
    /// @arg mx
    /// @arg my
    /// @arg object

    var _top_instance = noone;

    var _list = ds_list_create();
    var _num = collision_point_list(mx, my, object, false, true, _list, false);
    if (_num > 0)
    {
        for (var i = 0; i < _num; ++i;)
        {
            _top_instance = _list[| ds_list_size(_list)-1]
        }
    }

    ds_list_destroy(_list);

    return _top_instance;
}


function layer_instance_top_position(mx, my, layer_id)
{
    /// @func layer_instance_top_position(mx, my, layer_id)
    /// @arg mx
    /// @arg my
    /// @arg layer_id
 
    var _top_instance = noone;
 
    // create list
    var _list = ds_list_create();
 
    // add layer objects to the list
    var _array = layer_get_all_elements(layer_id);

    var i = array_length(_array)-1;
    repeat (array_length(_array))
    {
        if (layer_get_element_type(_array[i]) == layerelementtype_instance)
        {
            var _inst = layer_instance_get_instance(_array[i]);
             
            if position_meeting(mx, my, _inst) ds_list_add(_list, _inst);
        }
        i -= 1;
    }
 
    // get top instance
    var _num = ds_list_size(_list);
    if (_num > 0)
    {
        for (var i = 0; i < _num; ++i;)
        {
            _top_instance = _list[| ds_list_size(_list)-1]
        }
    }
 
    // destroy list
    ds_list_destroy(_list);
 
    return _top_instance;
}