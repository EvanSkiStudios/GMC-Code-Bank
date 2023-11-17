/// debug_console(val1,val2,...)
var o=object_get_name(object_index)
var e="";
var s="";
var i=0;
repeat (argument_count) {
    s+=" "+string(argument[i++]);
}
switch event_type{
case ev_create: e="Create";break;
case ev_destroy: e="Destroy";break;
case ev_alarm: e="Alarm";break;
case ev_step: e="Step";break;
case ev_keyboard: e="Keyboard";break;
case ev_mouse: e="Mouse";break;
case ev_collision: e="Collision";break;
case ev_other:
    switch event_number{
    case 63:
        e="Async";
    break;
    default:
        e="Other";
    }
break;
case ev_draw: e="Draw";break;
case ev_keyrelease: e="KeyRelease";break;
default: e="Room";o="noone";}
show_debug_message(date_time_string(date_current_datetime())+" | "+o+" | "+e+" |"+s);