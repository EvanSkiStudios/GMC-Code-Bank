function string_lower_fast(str, offset, use_cache)
{    /// @desc "efficient" alternative to string_lower()
    /// @func string_lower_fast(string, [offset=0], [use_cache=true])
 
    static cache = ds_map_create(); // Create static cache for fast string lookup
    var og_string; // Used to preserve original string
 
    // Default [use_cache] to true if not defined
    if (is_undefined(use_cache)) { use_cache = true; }
 
    if (use_cache)
    {    // Check cache to return early
        if (ds_map_exists(cache, str))
        {
            return cache[? str];
        }
     
        og_string = str;  // Store original string
    }
 
    // Default [offset] to 0 if not defined
    if (is_undefined(offset)) { offset = 0; }
 
    // Convert string to lowercase
    repeat(string_length(str)-offset)
    {
        var byte = string_byte_at(str, ++offset);
     
        if (byte <= 90 && byte >= 65)
        {
            str = string_set_byte_at(str, offset, byte+32);
        }
    }

    // Cache string for quick future lookup
    if (use_cache)
    {
        cache[? og_string] = str;
    }
 
    return str; // Return lowercase string
}

function string_upper_fast(str, offset, use_cache)
{    /// @desc "efficient" alternative to string_upper()
    /// @func string_upper_fast(string, [offset=0], [use_cache=true])
 
    static cache = ds_map_create(); // Create static cache for fast string lookup
    var og_string; // Used to preserve original string
 
    // Default [use_cache] to true if not defined
    if (is_undefined(use_cache)) { use_cache = true; }
 
    if (use_cache)
    {    // Check cache to return early
        if (ds_map_exists(cache, str))
        {
            return cache[? str];
        }
     
        og_string = str;  // Store original string
    }
 
    // Default [offset] to 0 if not defined
    if (is_undefined(offset)) { offset = 0; }
 
    // Convert string to uppercase
    repeat(string_length(str)-offset)
    {
        var byte = string_byte_at(str, ++offset);
     
        if (byte >= 97 && byte <= 122)
        {
            str = string_set_byte_at(str, offset, byte-32);
        }
    }

    // Cache string for quick future lookup
    if (use_cache)
    {
        cache[? og_string] = str;
    }
 
    return str; // Return uppercase string
}