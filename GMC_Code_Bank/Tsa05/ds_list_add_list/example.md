Warning: These functions are magical and also poison. By marking a list item as a data structure, GameMaker will automatically clean up (destroy) child structures when the parent structure is destroyed. This is a blessing for memory management, and a curse if you needed those lists elsewhere ;D

```
ds_list_add_list(id, list)
```

Add a list to a list, marking it as a list.