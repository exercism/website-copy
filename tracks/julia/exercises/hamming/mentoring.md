# Mentoring

## Things to think about

Broadcasting solutions like `count(collect(s1) .!= collect(s2))` will create copies of both inputs, and a new vector for the logical array too. That's 3N memory use when there's an obvious algorithm that's O(1) memory use.

You can use `sum`, but you'll probably need to jump through hoops to get it to handle the case of an empty generator. `count` is easier.

## Example solutions

````
```julia
function distance(s1, s2)
    length(s1) != length(s2) && throw(ArgumentError("Sequences must have the same length"))
    count(a != b for (a, b) in zip(s1, s2))
end
```
````

There's a nice solution with mapreduce, too, especially nice because mapreduce makes it easy to iterate multiple collections at the same time without `zip`.

````
[OTDE's solution](https://exercism.io/tracks/julia/exercises/hamming/solutions/eb84c62622fd41c0b92ddfae03ef9f01)

```julia
function distance(s1, s2)
    length(s1) ≠ length(s2) && throw(ArgumentError("Sequences must have the same length"))
    mapreduce(≠, +, s1, s2, init = 0)
end
```
````
