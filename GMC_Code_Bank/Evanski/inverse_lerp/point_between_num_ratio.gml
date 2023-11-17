function point_between_num_ratio(_min, _max, num){
  
    ///@desc returns a number between 0-1 depending on how close the input number is to each of the two other numbers provided
    // if the num is closer to _min its closer to 0, if the num is closer to _max its closer to 1, so you return a ratio of where you are between the two numbers 
  
    return( ( (num - _min) / (_max - _min) )  );
}