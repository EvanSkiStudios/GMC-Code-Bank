I wrote some useful functions for structs:  
[print() function here.](https://forum.yoyogames.com/index.php?threads/code-bank-share-useful-code.60575/page-2#post-489223)  
Usage Example:  

```gml
// ### Struct Operations ###
print("-------------------------------------------------");
global.main_struct = {
    highscores : [
        {name : "George", points : 100},
        {name : "Jack", points : 200},
        {name : "Foxy", points : 335},
    ],
    funct : function() {
        var test = true;
    },
    data : {
        icon : "gamemaker",
        url : "https://website.com",
    },
    value : 150,
}

struct_test = {
    EXISTING_VAR : 99999,
}
print("Original Struct 1: ", global.main_struct);
print("Original Struct 2: ", struct_test);


// copy
struct_copy(global.main_struct, struct_test);
print("Copied struct: ", struct_test);

// compare
var test = struct_compare(global.main_struct, struct_test);
print("Equal? ", test);

// struct clear
struct_clear(struct_test);
print("Struct cleared: ", struct_test);

// struct push
var _test_name = "enemies";
var _test_vars = ["robot", "village", "wolf"];
struct_push(struct_test, _test_name, _test_vars);
print("Struct push: ", struct_test);

// struct push with same name
var _struct = {
    aa : 10,
    bb : 20,
    cc : 30,
}
struct_push(_struct, "score", 99);
struct_push(_struct, "score", 99);
struct_push(_struct, "score", 99);
print("Struct push, same name", _struct);

// compare vars
var test = struct_compare_vars(global.main_struct, struct_test);
print("Struct and variables equal? ", test);

// struct replace
struct_replace(global.main_struct, struct_test);
print("Struct Replace: ", struct_test);

// struct multiply
var _original = {
    aa : 10,
}
var s1 = {};
var s2 = {};
var s3 = {};
struct_multiply(_original, [s1, s2, s3]);
print("Struct Multiply: ", s1, s2, s3);

// struct pop
var _struct = {
    number1 : 100,
    str1 : "test",
    arrayy : [50, 350, 88],
    letters : {
        aa : 5,
        bb : 6,
        cc : 7,
    }
}

print("Struct Pop, before: ", _struct);
var test = struct_pop(_struct, "arrayy");

print("Struct Pop, variable: ", test);
print("Struct Pop, after: ", _struct);

var test = struct_pop(_struct.letters, "bb");
print("Popped child variable: ", test);

print("Struct Pop, after all: ", _struct);


// for loading game data
my_apples = 0;
my_oranges = 0;
my_potatoes = 0;
my_array = [];

var _json = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000 }, \"myArray\":[0, 1, 2]}";
var _data = json_parse(string(_json));

if struct_child_exists(_data, "myObj") {
    var _struct = _data.myObj;
    my_apples = struct_var_read(_struct, "apples", my_apples);
    my_oranges = struct_var_read(_struct, "oranges", my_oranges);
    my_potatoes = struct_var_read(_struct, "potatoes", my_potatoes);
}
 
if struct_child_exists(_data, "myArray") {
    var _array = _data.myArray;
    my_array = _array;
}

print("Vars: ", my_apples, my_oranges, my_potatoes, "-", "Array: ", my_array);
```

RESULT:
```
Original Struct 1: | { data : { icon : "gamemaker", url : "https://website.com" }, value : 150, highscores : [ { name : "George", points : 100 },{ name : "Jack", points : 200 },{ name : "Foxy", points : 335 } ], funct : function gml_Script_anon____struct___1_gml_Object_Object1_Create_0_252____struct___1_gml_Object_Object1_Create_0 } |
Original Struct 2: | { EXISTING_VAR : 99999 } |
Copied struct: | { data : { icon : "gamemaker", url : "https://website.com" }, value : 150, highscores : [ { name : "George", points : 100 },{ name : "Jack", points : 200 },{ name : "Foxy", points : 335 } ], EXISTING_VAR : 99999, funct : function gml_Script_anon____struct___1_gml_Object_Object1_Create_0_252____struct___1_gml_Object_Object1_Create_0 } |
Equal? | 1 |
Struct cleared: | { } |
Struct push: | { enemies : [ "robot","village","wolf" ] } |
Struct push, same name | { score : 99, score0 : 99, aa : 10, score1 : 99, bb : 20, cc : 30 } |
Struct and variables equal? | 0 |
Struct Replace: | { data : { icon : "gamemaker", url : "https://website.com" }, value : 150, highscores : [ { name : "George", points : 100 },{ name : "Jack", points : 200 },{ name : "Foxy", points : 335 } ], funct : function gml_Script_anon____struct___1_gml_Object_Object1_Create_0_252____struct___1_gml_Object_Object1_Create_0 } |
Struct Multiply: | { aa : 10 } | { aa : 10 } | { aa : 10 } |
Struct Pop, before: | { str1 : "test", arrayy : [ 50,350,88 ], letters : { aa : 5, bb : 6, cc : 7 }, number1 : 100 } |
Struct Pop, variable: | [ 50,350,88 ] |
Struct Pop, after: | { str1 : "test", letters : { aa : 5, bb : 6, cc : 7 }, number1 : 100 } |
Popped child variable: | 6 |
Struct Pop, after all: | { str1 : "test", letters : { aa : 5, cc : 7 }, number1 : 100 } |
Vars: | 10 | 12 | 100000 | - | Array: | [ 0,1,2 ] |
```

I'll also leave here a script made by: [@Sad](https://forum.gamemaker.io/index.php?members/65289/) posted [here:](https://forum.yoyogames.com/index.php?threads/is-it-possible-to-create-a-structured-array-or-map.92535/#post-556129)
(I don't recommend using ds_maps anymore, use structs!)  

```gml
function ds_map_from_struct(struct) {
    var ds_map = ds_map_create();
    var keys = variable_struct_get_names(struct);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var value = variable_struct_get(struct, key);
        ds_map_add(ds_map, key, value);
    }
    return ds_map;
}

function struct_from_map(ds_map) {
    var struct = {};
    var keys = ds_map_keys_to_array(ds_map);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var value = ds_map_find_value(ds_map, key);
        variable_struct_set(struct, key, value);
    }
    return struct;
}

function struct_from_array(array) {
    var struct = {};
    for (var i = 0; i < array_length(array); i++) {
        variable_struct_set(struct, i, array[i]);
    }
    return struct;
}

function struct_from_instancevars(instanceid) {
    var struct = {};
    var keys = variable_instance_get_names(instanceid);
    for (var i = 0; i < array_length(keys); i++){
        var key = keys[i];
        var value = variable_instance_get(instanceid, key);
        variable_struct_set(struct, key, value);
    }
    return struct;
}
```