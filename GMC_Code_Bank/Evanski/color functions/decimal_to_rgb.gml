function decimal_to_rgb(decimal, mutation=0){
  // Extract the individual red, green, and blue values from the decimal
  //gamemaker is big endien so we swap red and blue
  var blue = (decimal >> 16) & 0xff;
  var green = (decimal >> 8) & 0xff;
  var red = decimal & 0xff;

  // Apply the mutation to the red, green, and blue values
  if (mutation != 0){
      red = red + irandom_range(-mutation, mutation);
      green = green + irandom_range(-mutation, mutation);
      blue = blue + irandom_range(-mutation, mutation);
  }

  // Clamp the red, green, and blue values to the range 0-255
  red = clamp(red, 0, 255);
  green = clamp(green, 0, 255);
  blue = clamp(blue, 0, 255);

  // Return the RGB values as an array
  return [red, green, blue];
}