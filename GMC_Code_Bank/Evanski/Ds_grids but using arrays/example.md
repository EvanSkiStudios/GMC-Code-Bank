ds_grid functionality but using 2D grids
If anyone wants a certain ds_grid function ported, I'll look into it  

```gml
array = es_grid_create(10,10,0);

show_debug_message( es_grid_rows(array) );
show_debug_message( es_grid_columns(array) );


for (var i = 0; i < 8; ++i){
    array[i][i] = 1;
}

show_debug_message(array);

es_grid_set(array,3,3,7);

show_message(es_grid_get(array, 3, 3));

show_debug_message(array);

es_grid_clear(array,9);

show_debug_message(array);
```