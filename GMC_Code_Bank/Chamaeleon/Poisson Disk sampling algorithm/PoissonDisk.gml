/// @function PoissonDisk(width, height, radius, k);
/// @param {number} width The width of the poission distribution
/// @param {number} height The height of the poission distribution
/// @param {number} radius The radius for preventing overlap
/// @param {number} k The number of points to try in each grid cell
/// @description Create a struct for poisson distribution
function PoissonDisk(_width, _height, _radius, _k) constructor {
    width = _width;
    height = _height;
    radius = _radius;
    k = _k;
    /* Figure out no. of cells in the grid for our canvas */
    cellsize = floor(radius/sqrt(2));
    ncells_width = ceil(width/cellsize) + 1;
    ncells_height = ceil(height/cellsize) + 1;

    static __isValidPoint = function(grid, cellsize, gwidth, gheight, p, radius) {
        /* Make sure the point is on the screen */
        if (p.x < 0 || p.x >= width || p.y < 0 || p.y >= height)
            return false;

        /* Check neighboring eight cells */
        var xindex = floor(p.x / cellsize);
        var yindex = floor(p.y / cellsize);
        var i0 = max(xindex - 1, 0);
        var i1 = min(xindex + 1, gwidth - 1);
        var j0 = max(yindex - 1, 0);
        var j1 = min(yindex + 1, gheight - 1);

        //log("Checking grid [%1 %2] -- [%3 %4, %5 %6]", xindex, yindex, i0, i1, j0, j1);
        for (var i = i0; i <= i1; i++)
            for (var j = j0; j <= j1; j++)
                if (grid[i][j] != undefined)
                    if (point_distance(grid[i][j].x, grid[i][j].y, p.x, p.y) < radius)
                        return false;

        /* If we get here, return true */
        return true;
    }

    static __insertPoint = function(grid, cellsize, point) {
        var xindex = floor(point.x / cellsize);
        var yindex = floor(point.y / cellsize);
        grid[xindex][yindex] = point;
    }

    /// @function generate();
    /// @description Generate and return an array of poisson distributed points
    static generate = function() {
        var points = [];
        /* The currently "active" set of points */
        var active = [];
        /* Initial point p0 */
        var p0 = { x: random(width), y: random(height) };
        var grid = [];
  
        /* Allocate the grid an initialize all elements to null */
        for (var i = 0; i < ncells_width; i++) {
            grid[i] = array_create(ncells_height, undefined);
        }

        __insertPoint(grid, cellsize, p0);
        array_push(points, p0);
        array_push(active, p0);

        while (array_length(active) > 0) {
            var random_index = irandom(array_length(active)-1);
            var p = active[random_index];
  
            var found = false;
            for (var tries = 0; tries < k; tries++) {
                var theta = random(360);
                var new_radius = random_range(radius, 2*radius);
                var pnewx = p.x + new_radius * dcos(theta);
                var pnewy = p.y + new_radius * dsin(theta);
                var pnew = { x: pnewx, y: pnewy };
    
                if (!__isValidPoint(grid, cellsize, ncells_width, ncells_height, pnew, radius)) {
                    continue;
                }
    
                array_push(points, pnew);
                __insertPoint(grid, cellsize, pnew);
                array_push(active, pnew);
                found = true;
                break;
            }
  
            /* If no point was found after k tries, remove p */
            if (!found) {
                array_delete(active, random_index, 1);
            }
        }
      
        return points;
    }
}