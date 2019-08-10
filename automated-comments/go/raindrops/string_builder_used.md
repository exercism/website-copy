The `%{function}` is helpful when concatenating a lot of little parts to a string.
In a use case like this it is overkill. Here the `+=` operator is faster und uses less memory.
This can be verified running the benchmarks as described in the exercise instructions.
