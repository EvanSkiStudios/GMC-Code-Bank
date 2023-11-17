Script function converting sprite_get_uvs to croppings in pixels on each side:
https://forum.gamemaker.io/index.ph...-to-complete-bounding-box.101899/#post-615377

GM v2022.11, v2023.1, with only limited manual testing on a few frames:
```gml
sprite_get_croppings(_spr_index, _img_index=0)
```

Legacy GM 1.4 (ported by @follow-the-fun, returning an array instead of a struct)
```gml
sprite_get_croppings(spr,subimg)
```

Code used to test from @follow-the-fun  

```gml
// NOTE: This code only works if the rotation point of the sprite is 0,0 (not centered).
// To use a centered sprite, you'd need to offset all coordinates by it rotation point (use sprite_get_xoffset)
// Test 1
var testX = 200; var testY = 200;
var testSprite = spr_Test;
var testSub    = 0;
var croppings  = sprite_get_croppings(testSprite,testSub);

draw_sprite(testSprite,testSub,testX,testY);
draw_rectangle_colour(testX,testY,testX+sprite_get_width(testSprite),testY+sprite_get_height(testSprite),c_black,c_black,c_black,c_black,1); // Sprite bounding box
draw_rectangle_colour(testX+croppings[0],testY+croppings[1],testX+sprite_get_width(testSprite)-croppings[2],testY+sprite_get_height(testSprite)-croppings[3],c_red,c_red,c_red,c_red,1);

// Test 2
var testX = 420; var testY = 200;
var testSprite = spr_Test;
var testSub    = 1;
var croppings  = sprite_get_croppings(testSprite,testSub);

draw_sprite(testSprite,testSub,testX,testY);
draw_rectangle_colour(testX,testY,testX+sprite_get_width(testSprite),testY+sprite_get_height(testSprite),c_black,c_black,c_black,c_black,1); // Sprite bounding box
draw_rectangle_colour(testX+croppings[0],testY+croppings[1],testX+sprite_get_width(testSprite)-croppings[2],testY+sprite_get_height(testSprite)-croppings[3],c_red,c_red,c_red,c_red,1);
```