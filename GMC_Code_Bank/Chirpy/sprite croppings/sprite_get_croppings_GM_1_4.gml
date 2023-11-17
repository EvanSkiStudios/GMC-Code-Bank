///sprite_get_croppings(spr,subimg)
/*
Returns the real croppings (in pixels) of a sprite on the texture
page, (taking into account the crops made by game maker to remove
white space).
*/

// Arguments
var _spr_index = argument0; // The sprite to check for croppings
var _img_index = argument1; // The subimage of that sprite

// Retrieve built in uvs
var info = sprite_get_uvs(_spr_index,_img_index);

// Assemble an array containing the croppings
var croppings;
croppings[3] = sprite_get_height(_spr_index)*(1-info[7])-info[5]; // Bottom (order reversed)
croppings[2] = sprite_get_width(_spr_index)*(1-info[6])-info[4]; // Right
croppings[1] = info[5]; // Top (these two are as default from game maker)
croppings[0] = info[4]; // Left

// Return new array;
return croppings;