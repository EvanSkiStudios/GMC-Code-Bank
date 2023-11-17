Since string_lower() and string_upper() are VERY slow, I've made alternative scripts which, on typical use cases, run much faster:  
- string_lower_fast()
- string_upper_fast()

```gml
string_lower_fast(str, offset, use_cache)

string_upper_fast(str, offset, use_cache)
```