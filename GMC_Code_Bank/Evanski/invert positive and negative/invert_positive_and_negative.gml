function Positive(value){
    //returns a input number but as positive
    return abs(value);
}

function Negative(value){
    //returns a input number but as negative
    var get_negative = sign(value);
    
    if (get_negative != -1){
        return value * -1;
    }else{
        return value;   
    }
}

/*

or just use

function Negative(value) {
    return -abs(value);
}
*/