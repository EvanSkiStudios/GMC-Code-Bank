function sprite_get_croppings(_spr_index, _img_index=0)
{
    var info = sprite_get_uvs(_spr_index,_img_index);
    return {
        left: info[4],
        top: info[5],
        right: sprite_get_width(_spr_index)*(1-info[6])-info[4],
        bottom: sprite_get_height(_spr_index)*(1-info[7])-info[5],
    };
}