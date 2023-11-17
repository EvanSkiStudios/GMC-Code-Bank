I've found myself posting these file-reading/writing and JSON-reading/writing functions on multiple occasions, so I figured I might as well post these here.
This includes file functions to reading all text content, writing all text content, loading a JSON file to a value and writing a value to a JSON file.

```gml
file_read_all_text(_filename)

file_write_all_text(_filename, _content)

json_load(_filename)

json_save(_filename, _value)
```