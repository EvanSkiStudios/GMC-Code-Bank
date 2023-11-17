function string_format_var(str) {
  
//Formats a string so it's safe to use as a variable name
//ei. with underscores instead of spaces and all lower case
  
    return string_replace_all(string_lower(str), " ", "_")
}