function part_type_get_uvs(_type, _sf_size = 512) {

    #region Functions to keep code a bit tidy

    function pixel_read(_buffer) {
        var _r = buffer_read(_buffer, buffer_f32);
        var _g = buffer_read(_buffer, buffer_f32);
        var _b = buffer_read(_buffer, buffer_f32);
        var _a = buffer_read(_buffer, buffer_f32);

        return [_r, _g, _b, _a];
    }

    function pixel_is_valid(_pixel) {
        // Define "some" combination of b and a to define whether a pixel is valid or not
        return (_pixel[2] == .5 && _pixel[3] == 1);
    }

    #endregion

    #region Create "dummy" particle system, type and particle

    var _ps = part_system_create();
    part_system_automatic_draw(_ps, false);
    var _pt = part_type_create();
    part_type_shape(_pt, _type);
    part_particles_create(_ps, _sf_size/2, _sf_size/2, _pt, 1);
    part_system_update(_ps);    // Update ONCE so we have a particle

    #endregion

    #region Create buffer

    var _component_size = buffer_sizeof(buffer_f32);
    var _components_per_pixel = 4;
    var _bytes_per_pixel = _components_per_pixel * _component_size;
    var _num_pixels = _sf_size * _sf_size;
    var _buffer_bytesize = _num_pixels * _components_per_pixel * _component_size;

    var _buff = buffer_create(_buffer_bytesize, buffer_grow, 1);
    buffer_fill(_buff, 0, buffer_f32, 0, _buffer_bytesize);

    #endregion

    #region Perform "drawing", i.e. get the data out

    // Create a surface of a size big enough to accommodate the sprite/texture
    var _sf = surface_create(_sf_size, _sf_size, surface_rgba32float);

    surface_set_target(_sf);

        shader_set(sha_output_uv);
    
        part_system_drawit(_ps);

        shader_reset();

    surface_reset_target();

    buffer_get_surface(_buff, _sf, 0);

    #endregion

    #region Get the values out of the buffer

    var _uvs = [0, 0, 0, 0, 0, 0, 0, 0];

    var _tw = 0, _th = 0;

    // Brute-force loop through buffer data to find start and width
    buffer_seek(_buff, buffer_seek_start, 0);
    var _pixel = -1, _topleft = -1, _width = -1;
    for(var i = 0;i < _num_pixels;i++) {
        _pixel = pixel_read(_buff);

        if (pixel_is_valid(_pixel)) {
            // This is a valid pixel written by the shader!
        
            // Process it
            if (_topleft == -1) {
                // Get texel dimensions by moving a single pixel
                var _pixel_next = pixel_read(_buff);
                _tw = _pixel_next[0] - _pixel[0];
                buffer_seek(_buff, buffer_seek_relative, (_sf_size - 1) * _bytes_per_pixel);
                var _pixel_below = pixel_read(_buff);
                _th = _pixel_below[1] - _pixel[1];
                buffer_seek(_buff, buffer_seek_relative, -(1 + _sf_size) * _bytes_per_pixel);
            
                // The first one we encounter is the top-left pixel
                var _u = _pixel[0]; _uvs[0] = floor(_u/_tw) * _tw;
                var _v = _pixel[1]; _uvs[1] = floor(_v/_th) * _th;
                _topleft = i;
            }
        }

        if ((_pixel[2] == 0 && _pixel[3] == 0) && _topleft >= 0 && _width == -1) {
            // This is the first pixel after the first row
            _width = i - _topleft;
            break;
        }
    }

    // Now that we have the width, we can find the height more efficiently
    var _height = 0;
    buffer_seek(_buff, buffer_seek_start, _topleft * _bytes_per_pixel);
    do {
        _pixel = pixel_read(_buff);
        buffer_seek(_buff, buffer_seek_relative, (_sf_size - 1) * _bytes_per_pixel);
        _height++;
    } until(!pixel_is_valid(_pixel));
    _height--;

    buffer_seek(_buff, buffer_seek_start, (_topleft+(_height-1)*_sf_size+_width-1) *_bytes_per_pixel);
    var _px = pixel_read(_buff);
    _uvs[2] = (ceil(_px[0]/_tw)) * _tw;
    _uvs[3] = (ceil(_px[1]/_th)) * _th;

    _uvs[4] = _width;
    _uvs[5] = _height;

    _uvs[6] = _tw;
    _uvs[7] = _th;

    #endregion

    #region Cleanup

    buffer_delete(_buff);
    surface_free(_sf);

    part_type_destroy(_pt);
    part_system_destroy(_ps);

    #endregion

    return _uvs;
}