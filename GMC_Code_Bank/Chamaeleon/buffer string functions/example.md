Reading lines from a buffer and finding the position of a substring in a buffer  
```gml
global.buffer_string_copy = buffer_create(1, buffer_grow, 1); // Remains allocated throughout the lifetime of the program
```

Usage  
```gml
var buf = buffer_create(1, buffer_grow, 1);
buffer_write(buf, buffer_text, "Hello, World!\n");
buffer_write(buf, buffer_text, "Once upon a time...\n");
buffer_write(buf, buffer_text, "Alice, Bob, and Charlie\n");
buffer_write(buf, buffer_text, "See Spot. See Spot Run. Run, Spot, Run.");
buffer_save(buf, "testing.txt");
buffer_delete(buf);

show_debug_message("Testing Reading Lines");
var buf = buffer_load("testing.txt");
while (buffer_tell(buf) < buffer_get_size(buf)) {
    var line = buffer_string_readln(buf);
    if (string_copy(line, string_length(line), 1) == "\n")
        line = string_copy(line, 0, string_length(line)-1);
    show_debug_message("Line [" + line + "]");
}
buffer_delete(buf);

show_debug_message("Testing finding a substring");
var buf = buffer_load("testing.txt");
if (buffer_find_substr(buf, "Alice")) {
    var pos = buffer_tell(buf);
    var line = buffer_string_readln(buf);
    if (string_copy(line, string_length(line), 1) == "\n")
        line = string_copy(line, 0, string_length(line)-1);
    show_debug_message("Found [" + line + "] at position " + string(pos));
}
buffer_delete(buf);

file_delete("testing.txt");
```

```
Testing Reading Lines
Line [Hello, World!]
Line [Once upon a time...]
Line [Alice, Bob, and Charlie]
Line [See Spot. See Spot Run. Run, Spot, Run.]
Testing finding a substring
Found [Alice, Bob, and Charlie] at position 34
```

(Yes, creating a new string for every position called for buffer_check_pos() instead of creating a buffer once for substr and using it over and over for comparison is, well, inefficient is a word that comes to mind)