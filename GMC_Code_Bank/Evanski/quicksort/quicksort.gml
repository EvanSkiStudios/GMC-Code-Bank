/*
QUICKSORT
This is adapted from The coding train
https://www.youtube.com/watch?v=eqo2LxRADhU

For future reference, the quickswap returns nothing, it modifies the existing array to be sorted
*/

function array_swap(arr, a, b){
    var temp = arr[a];
    arr[a] = arr[b];
    arr[b] = temp;  
}

function QuickSort(arr, start, _end){
    if (start >= _end){ return; }
    var partition = function(arr, start, _end){
        var pivotIndex = start;
        var pivotValue = arr[_end];
        for (var i = start; i < _end; ++i){
            if (arr[i] < pivotValue){
                array_swap(arr, i, pivotIndex);
                ++pivotIndex;
            }
        }
        array_swap(arr, pivotIndex, _end);
        return pivotIndex;
    }
    var index = partition(arr, start, _end);
    QuickSort(arr, start, index-1);
    QuickSort(arr, index +1, _end);
}