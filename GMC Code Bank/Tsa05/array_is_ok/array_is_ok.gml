///    @desc    Returns true if a valid index within a valid array is found
///    @arg    {real}    array
///    @arg    {real}    index
var ary = argument[0];
var ind = argument[1];

return (ind>=0 && is_array(ary) && ind<array_length_1d(ary));