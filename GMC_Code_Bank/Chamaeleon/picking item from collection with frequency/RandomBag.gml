function RandomBag() constructor {
    bag = [];
    sum = 0;
  
    static add = function(thing, frequency) {
        array_push(bag, { thing: thing, frequency: frequency });
        sum += frequency;
    }
  
    static remove = function(thing) {
        var i = 0;
        repeat array_length(bag) {
            if (bag[i].thing == thing) {
                sum -= bag[i].frequency;
                array_delete(bag, i, 1);
                break;
            }
            i++;
        }
    }
  
    static pick = function() {
        var accum = 0;
        var n = random(sum);
        var i = 0;
        repeat array_length(bag) {
            accum += bag[i].frequency;
            if (n <= accum) {
                break;
            }
            i++;
        }
        return bag[i].thing;
    }
}