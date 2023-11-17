function smoothstep(minv, maxv, value) {
    var t = clamp((value - minv) / (maxv - minv), 0, 1);
    return t * t * (3 - 2 * t);
}