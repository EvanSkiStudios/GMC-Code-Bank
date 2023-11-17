function approxEqual(value, target, tolerance = 0.01) {
    if(abs(value - target) <= abs(tolerance)) { return(true); }
    return(false);
}