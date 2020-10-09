# Example solutions

````
[cmcaine's solution](https://exercism.io/tracks/julia/exercises/triangle/solutions/6a5d3f2839de4573976e6af751ff6295#solution-comment-169566)
based on counting the number of unique sides gives simple definitions that are
trivially easy to prove correct, but `unique` is a bit expensive---we can go faster :)

```julia
# I verify that `sides` is three elements long, tho you
# could also assume that from the specification.
#
# As well as being safer, this check can help the compiler.

is_triangle(sides) = (length(sides) == 3
                      && all(>(0), sides)
                      && 2 * maximum(sides) < sum(sides))

# Mathematical-ish solution
is_equilateral(sides) = is_triangle(sides) && length(unique(sides)) == 1
is_isosceles(sides)   = is_triangle(sides) && length(unique(sides)) <= 2
is_scalene(sides)     = is_triangle(sides) && length(unique(sides)) == 3
```

If we want to go faster, we can check out these fast variants, also in
[cmcaine's solution](https://exercism.io/tracks/julia/exercises/triangle/solutions/6a5d3f2839de4573976e6af751ff6295#solution-comment-169566).

This code makes liberal use of Julia's [chaining comparisons](https://docs.julialang.org/en/v1/manual/mathematical-operations/#Chaining-comparisons).
`is_isosceles` is defined more or less as "not scalene" because that happens to be shorter to write and perhaps faster.

Both of these solutions assume that the elements of `sides` can be tested against `0`, which seems reasonable enough, but what if we give the sides in `Meters` using [Unitful.jl](http://painterqubits.github.io/Unitful.jl/stable/)?
To guard against cases like that, it might be better to replace the two `0`s with `zero(eltype(sides))`, which will be replaced (usually at compile-time) with the `zero` value of the element type of `sides`.

```julia
# Reusing is_triangle from before
is_equilateral(sides) = length(sides) == 3 && sides[1] == sides[2] == sides[3] > 0
is_isosceles(sides)   = !(sides[1] != sides[2] != sides[3] != sides[1]) && is_triangle(sides)
is_scalene(sides)     = sides[1] != sides[2] != sides[3] != sides[1] && is_triangle(sides)
```

[A simple by-hand version be Nosferican](https://exercism.io/tracks/julia/exercises/triangle/solutions/7133eccd34ed49f38edecb8672b02263).
As is often the case, this simple solution is fast!

Nosferican's use of ternary expressions where they could use short-circuit operators is a bit peculiar, but still perfectly readable.

```julia
is_triangle(sides) = all(x -> x > zero(x), sides) &&
                     sides[1] + sides[2] ≥ sides[3] &&
                     sides[1] + sides[3] ≥ sides[3] &&
                     sides[2] + sides[3] ≥ sides[1]

is_equilateral(sides) = is_triangle(sides) ?
                        sides[1] == sides[2] == sides[3] :
                        false

is_isosceles(sides) = is_triangle(sides) ?
                      sides[1] == sides[2] ||
                      sides[1] == sides[3] ||
                      sides[2] == sides[3] :
                      false

is_scalene(sides) = is_triangle(sides) ?
                    sides[1] ≠ sides[2] &&
                    sides[1] ≠ sides[3] &&
                    sides[2] ≠ sides[3] :
                    false
```

## Honourable mentions

Sorting the sides gives a natural definition of the triangle inequality and saves some typing, but sorting and allocating vectors is expensive stuff, especially when done twice for every check (no, Julia can't tell that the two `sort` calls could be merged together).

[CNOT's solution](https://exercism.io/tracks/julia/exercises/triangle/solutions/39733f947aba4a3ca313a31e07316085)


```julia
function is_equilateral(sides)
    (l1,l2,l3) = sort(sides)
    return is_triangle(sides) && l1 == l3
end

function is_isosceles(sides)
    (l1,l2,l3) = sort(sides)
    return is_triangle(sides) && (l1 == l2 || l2 == l3)
end

function is_scalene(sides)
    return is_triangle(sides) && !is_isosceles(sides)
end


function is_triangle(sides)
    (l1,l2,l3) = sort(sides)
    return l1 > 0 && l1+l2>l3
end
```

xyshell eliminated the double sort to get okay performance, which is neat.
But now `is_equilateral` mutates its input argument and doesn't have a `!` at the end of its name, so that's a bit dangerous:
other Julians might use this code under the assumption that the input will not be mutated and then get strange bugs.

```julia
function is_valid!(sides)
    sort!(sides)
    !(sides[1] <= 0 || sides[1] + sides[2] <= sides[3])
end

function is_equilateral(sides)
    is_valid!(sides) && sides[1] == sides[3]
end

function is_isosceles(sides)
    is_valid!(sides) && (sides[1] == sides[2] || sides[2] == sides[3])
end

function is_scalene(sides)
    is_valid!(sides) && !is_isosceles(sides)
end
```
````
