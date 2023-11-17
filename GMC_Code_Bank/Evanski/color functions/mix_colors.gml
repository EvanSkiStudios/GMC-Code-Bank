function mix_colors(color1, color2){
  // Extract the individual red, green, and blue values from the colors
  var red1 = color1[0];
  var green1 = color1[1];
  var blue1 = color1[2];
  var red2 = color2[0];
  var green2 = color2[1];
  var blue2 = color2[2];

  // Calculate the average of the red, green, and blue values
  var red = (red1 + red2) / 2;
  var green = (green1 + green2) / 2;
  var blue = (blue1 + blue2) / 2;

  // Return the mixed color as an array of RGB values
  return [red, green, blue];
}