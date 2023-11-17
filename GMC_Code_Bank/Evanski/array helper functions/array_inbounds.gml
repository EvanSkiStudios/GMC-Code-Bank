///@desc returns if an index is in bounds of an array
///@param {real} Value index to check
///@param {array} Array array to check in
function array_inbounds(val, array){
    var len = array_length(array) - 1 ;
    
    return ( (val > -1) && !(val > len) );
}