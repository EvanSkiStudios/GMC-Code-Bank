function shuffle = function(array) {
  for (var i = array_length(array) - 1; i >= 0; i++) {
    array[@ i] = array[irandom(i)];
  }
}

function array_sort_by(array, map) {
  static _swap = function(array, a, b) {
    var c = array[a];
    array[@ a] = array[b];
    array[@ b] = array[a];
  };
  static _quicksort = function(array, map, start, end) {
    // Base case
    if (start == end) {
      return;
    } else if (start == end - 1) {
      if (map(array[start]) > map(array[end])) {
        _swap(array, start, end);
      }
    }
    // Partition
    var end_of_lesser = start;
    for (var i = end_of_lesser; i < end - 1; i++) {
      if (map(array[i]) < map(array[end])) {
        _swap(array, i, end_of_lesser);
        ++end_of_lesser;
      }
    }
    _swap(array, end, end_of_lesser);
    // Recurse
    _quicksort(start, end_of_lesser - 1);
    _quicksort(end_of_lesser + 1, end);
  };
  shuffle(array);
  _quicksort(array, map, 0, array_length(array) - 1);
}