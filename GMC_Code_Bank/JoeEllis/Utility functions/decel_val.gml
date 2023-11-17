function decel_val(val, amt) {

//Moves a value (negative or positive) towards zero.
//Useful for deceleration of speed variables
//Has a quicker\sharper effect than lerping or multiplying speed by 0.9 etc.
//Similar effect to older games

    if val = 0
    {return 0}

    var s = sign(val);

    val -= amt * s

    if s != sign(val)
    {return 0}

    return val
}