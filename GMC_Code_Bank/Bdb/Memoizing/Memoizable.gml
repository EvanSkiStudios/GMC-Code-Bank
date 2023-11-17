function __Callable (func, args) constructor {
    __func = func;
    __args = args;

    toString = function () {
        return string(__func) + string(__args);
    }

    call = function () {
        switch (array_length(__args)) {
            case 0: return __func(); break;
            case 1: return __func(__args[0]); break;
            case 2: return __func(__args[0], __args[1]); break;
            case 3: return __func(__args[0], __args[1], __args[2]); break;
            case 4: throw "Please stop, reconsider the number of arguments you're passing.";
        }
    }

    return self
}

function Memoizable () constructor {
    memoizations = {};

    // @param {__Callable} callable
    __applyMemoization = function (callable) {
        var value = callable.call()
        memoizations[$ callable.toString()] = value;
  
        return value;
    }

    // @param {__Callable} callable
    __retrieveMemoization = function (callable) {
        return memoizations[$ callable.toString()];
    }

    // @param {Function} func
    memoize = function ( func ) {
        return method({
            func: func,
            applyMemoization: __applyMemoization,
            retrieveMemoization: __retrieveMemoization,
        }, function () {
            var count = argument_count;
            var args = array_create(count);
            for (var i = 0; i < argument_count; i++) {
                args[@ i] = argument[i];
            }
            var callable = __Callable(func, args);
            var memoized = retrieveMemoization(callable);
      
            if memoized == undefined {
                return applyMemoization(callable);
            }
            else {
                return memoized;
            }
        });
    }
}