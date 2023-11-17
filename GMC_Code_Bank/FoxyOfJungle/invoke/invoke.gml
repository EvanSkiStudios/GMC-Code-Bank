function invoke(callback, args, time, repetitions=1) {
    var _ts = time_source_create(time_source_game, time, time_source_units_frames, callback, args, repetitions);
    time_source_start(_ts);
    return _ts;
}