```gml
// Example:
BEGIN_ASSERT something() END_ASSERT
```

Two macros together create no-cost assertion. (debug_mode || os_get_config() == "debug") is a compile-time constant, and because of short-circuiting, something() will only ever be called if it is true. If I understand compilers correctly, the entire example code would be removed, if not by the preprocessor, then by some later step.