Using the `init` function should be avoided:
1) It slows down startup time and the developer using the package cannot do anything about it apart from removing the `init` function.
2) Using the `init` function is mostly used to initialize `global variables`. 
Global state in turn [should also be avoided](https://dave.cheney.net/practical-go/presentations/qcon-china.html#_avoid_package_level_state).
