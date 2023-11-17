function float_step()
{
    float_angle += float_speed;
    y -= float_y;
    float_y = lengthdir_y(float_range, float_angle);
    y += float_y;
}