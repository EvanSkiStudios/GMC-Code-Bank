I'm pretty terrible about minding performance. So I built a utility for memoizing expensive calls...

can be used like this:  
```gml
function MyExpensiveCode () : Memoizable () constructor {
    memoizedPlaceMeeting = memoize (
        function (x, y, obj) {
            return place_meeting(x, y, obj);
        }
    )
}
```
The `Memoizable` struct will always return the cached value if it's (a) been computed before, and (b) the arguments are the same. Pretty neat :)