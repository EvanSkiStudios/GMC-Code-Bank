/// Reads a SHA1 hash from a buffer and converts it into a string
///
/// @return SHA1 string extracted from the buffer
/// @param buffer   Buffer to read from
/// @param [lower]  Optional. Whether to force the SHA1 string into lowercase for easier comparison with other SHA1 strings. Defaults to <true>

function buffer_read_sha1()
{
    var _buffer = argument[0];
    var _lower  = ((argument_count > 1) && (argument[1] != undefined))? argument[1] : true;
    
    var _sha1_string = "";
    
    repeat(5)
    {
        var _value = buffer_read(_buffer, buffer_u32);
        
        //Reverse bytes in the 32-bit word we pulled out
        _value = (((_value & 0xFF) << 24) | ((_value & 0xFF00) << 8) | ((_value >> 8) & 0xFF00) | (_value >> 24));
        
        //Checky hack with pointers to output a hex string
        _sha1_string += string(ptr(_value));
    }
    
    //If necessary, force lowercase abcdef
    if (_lower) _sha1_string = string_lower(_sha1_string);
    
    return _sha1_string;
}