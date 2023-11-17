function string_to_array(str) {

//Creates an array from a string
//The string uses commas to separate each value

    var
    commas = string_count(",", str),
    a, i = -1, comma;
    a[commas] = 0
    repeat commas
    {
    comma = string_pos(",", str)
    a[++i] = real(string_copy(str, 1, comma - 1))
    str = string_delete(str, 1, comma)
    }
    a[++i] = real(str)

    return a
}
