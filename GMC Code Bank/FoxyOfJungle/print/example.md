Advanced print function that allow multiple arguments:

```gml
print()
```

Examples:  
```gml
print();
print("AAA");
print("AAA", "BBB");
print("AAA", "BBB", "CCC");
print(4524, "ASD", true, false);
```

GMS 2 Console output:  
```
AAA
AAA | BBB |
AAA | BBB | CCC |
4524 | ASD | 1 | 0 |
```

Note: As the first function was empty, so it wasn't even printed on the console.
I needed this function when I had to quickly display multiple variables with the " | " separator on the same line on the console.