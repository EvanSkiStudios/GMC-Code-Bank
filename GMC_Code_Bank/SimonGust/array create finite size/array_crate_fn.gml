function array_create_fn(size, fn) {
    if (is_undefined(size)) throw("No size provided to array_create_fn()!");
    if (is_undefined(fn)) throw("No function provided to array_create_fn()!");
    var arr = array_create(size);
    for (var i = 0; i < size; i++) {
        switch (argument_count) {
            case  2: arr[i] = fn(i); break;
            case  3: arr[i] = fn(i, argument[2]); break;
            case  4: arr[i] = fn(i, argument[2], argument[3]); break;
            case  5: arr[i] = fn(i, argument[2], argument[3], argument[4]); break;
            case  6: arr[i] = fn(i, argument[2], argument[3], argument[4], argument[5]); break;
            case  7: arr[i] = fn(i, argument[2], argument[3], argument[4], argument[5], argument[6]); break;
            case  8: arr[i] = fn(i, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7]); break;
            case  9: arr[i] = fn(i, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8]); break;
            case 10: arr[i] = fn(i, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9]); break;
            case 11: arr[i] = fn(i, argument[2], argument[3], argument[4], argument[5], argument[6], argument[7], argument[8], argument[9], argument[10]); break;
            default: throw("Too many arguments provided to array_create_fn()!"); break;
        }
    }
    return arr;
}

var arr = array_create(10, []);
for (var i = 0; i < array_length(arr); i++) { arr[i][@ 0] = i; }
show_debug_message(arr); // all entries point to the same one-element array

var arr = array_create_fn(10, function(i) { return []; });
for (var i = 0; i < array_length(arr); i++) { arr[i][@ 0] = i; }
show_debug_message(arr); // each entry is its own one-element array

var arr = array_create_fn(10, function(i, n) { return power(i, n); }, 2);
show_debug_message(arr);

/*
[ [ 9 ],[ 9 ],[ 9 ],[ 9 ],[ 9 ],[ 9 ],[ 9 ],[ 9 ],[ 9 ],[ 9 ] ]
[ [ 0 ],[ 1 ],[ 2 ],[ 3 ],[ 4 ],[ 5 ],[ 6 ],[ 7 ],[ 8 ],[ 9 ] ]
[ 0,1,4,9,16,25,36,49,64,81 ]
*/