I recently found out that [@ ] isn't only to directly modify array passed to script, but can also modify arrays returned from other scripts and assigned to different (temporary) variable:

```gml
globalvar BACKPACK, CHEST;
BACKPACK = array_create(10, -1); // 10 slots, -1 means no item
CHEST = array_create(50, -1); // 50 slots, -1 means no item

/// get reference of either backpack (true) or chest (false)
function get_storage(backpack = true) {
    return backpack ? BACKPACK : CHEST; // instead of if-else, there can be switch() here for more options :)
}

/// @param itemid
/// @param insert to backpack (true) or chest (false)
/// @returns true if item can be inserted and false if not
function put_item_into_storage(itemid, backpack = true) {
    var storage = get_storage(backpack);
    for(var i = 0; i < array_length(storage); i++) {
        if (storage[i] == -1) {
            storage[@ i] = itemid; /* MAGIC ! without using [@ ], storage would became a new array (copy of returned data). with [@ ] we can modify existing global array! */
            return true;
        }
    }
  
    return false;
}
```