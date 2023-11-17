/// debug_array(array)
var array = argument[0];
if(!is_array(array)){
    show_debug_message("Not an array! "+string(array));
}
var height = array_height_2d(array);
if(height>0){ //2D
    for(var row=0; row<height; row+=1){
        var txt = "| ";
        for(var col=0; col<array_length_2d(array, row); col+=1){
            txt += string(array[row, col])+" | ";
        }
        show_debug_message(txt);
    }
}else{
    var txt = "| ";
    for(var col=0; col<array_length_1d(array); col+=1){
        txt += string(array[col])+" | ";
    }
    show_debug_message(txt);
}