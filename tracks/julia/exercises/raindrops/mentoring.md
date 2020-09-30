## Mentoring suggestions

- Unrolled solutions are fine, don't require that students use loops or reduction or whatever.
- Prefer a tuple or vector of pairs to a Dict. There's no need to add values to the Dict or lookup items by key, so a simpler container is better.


## Example solutions

````
[ScottPJones' solution](https://exercism.io/tracks/julia/exercises/raindrops/solutions/05647a0a81ab43fdacf8f872d113df51).

This is about as fast as you can get without writing a tree of if/elses or a lookup table.

```julia
function raindrops(number::Real)
    f3 = number % 3 == 0
    f5 = number % 5 == 0
    f7 = number % 7 == 0
    ((f3 | f5 | f7)
     ? string(f3 ? "Pling" : "", f5 ? "Plang" : "", f7 ? "Plong" : "")
     : string(number))
end
```

[cmcaine's solution](https://exercism.io/tracks/julia/exercises/raindrops/solutions/d558034438c64bb9a949f90cfcdaad6a)

A solution (over?)designed to be easily extended or changed if the `noises` spec changed.
Repeatedly concatenating strings like this can be a bit slow compared to using an `IOBuffer` and `write()`, but this way is arguably easier to understand.

Some similar solutions use a `Dict` rather than a tuple, but a tuple of pairs is simpler and more efficient if you do not want to look up values by key.

```julia
function raindrops(n)
    noises = (3 => "Pling", 5 => "Plang", 7 => "Plong")
    acc = ""
    for (factor, noise) in noises
        n % factor == 0 && (acc *= noise)
    end
    isempty(acc) ? string(n) : acc
end
```

pdb5627's solution

Another simple, concise solution.

```julia
function raindrops(n)
    s = ""
    n % 3 == 0 && (s *= "Pling")
    n % 5 == 0 && (s *= "Plang")
    n % 7 == 0 && (s *= "Plong")
    s == "" && (s = string(n))
    return s
end
```
````
