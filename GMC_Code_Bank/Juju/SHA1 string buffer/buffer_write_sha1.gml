/// Writes a SHA1 string to a buffer as individual bytes, from left to right in the SHA1 string
///
/// @return Nothing (undefined)
/// @param buffer      Buffer to write to
/// @param sha1String  SHA1 string to write

function buffer_write_sha1(_buffer, _sha1_string)
{
    var _i = 1;
    repeat(5)
    {
        //Did you know real() worked on hex?
        var _value = real("0x" + string_copy(_sha1_string, _i, 8));
        
        //Reverse bytes in the 32-bit word
        //We do this so that the bytes in the buffer correspond exactly to the bytes in the SHA1 string
        _value = (((_value & 0xFF) << 24) | ((_value & 0xFF00) << 8) | ((_value >> 8) & 0xFF00) | (_value >> 24));
        
        buffer_write(_buffer, buffer_u32, _value);
        
        _i += 8;
    }
}