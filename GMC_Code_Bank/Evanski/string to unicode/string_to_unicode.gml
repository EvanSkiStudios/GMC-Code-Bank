function string_unicode(input_string){

    //make input uppercase so we are in 65-90 range
    input_string = string_upper(input_string);
    
    //get length
    input_string_length = string_length(input_string);
    
    //empty unicode string
    unicode_string = " ";
    
    //convert input word to numbers
    for (var i = 1; i < (input_string_length+1); ++i){
        var _n = ord(string_char_at(input_string,i));
        //adds the two numbers on unicode letter to the end of the string using a formula to get the pos it needs
        unicode_string = string_insert(string(_n),unicode_theme_word,string_length(unicode_string)+2);
    }
    
    return(unicode_string);
}