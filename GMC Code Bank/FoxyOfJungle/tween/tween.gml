function tween(curve, position, channels_array, channel_index) {
    var _cv_ch_lenght = array_length(channels_array);
    var _cv_ch = 0;
    var _cv = animcurve_get(curve);
    var _cv_value = 0;
    if (channel_index < _cv_ch_lenght) {
        _cv_ch = animcurve_get_channel(_cv, channels_array[@ channel_index]);
        _cv_value = animcurve_channel_evaluate(_cv_ch, position);
    }
    return _cv_value;
}