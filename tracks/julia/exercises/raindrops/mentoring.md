## Mentoring suggestions

- Unrolled solutions are fine, don't require that students use loops or reduction or whatever.
- Prefer a tuple or vector of pairs to a Dict. There's no need to add values to the Dict or lookup items by key, so a simpler container is better.
- If performance matters, constructing strings is slow! Profiling shows that `string(number)` and string concatenation are the biggest time sinks. Branching / lookup and remainder calculation are blazingly fast by comparison.


## Fast lookup / tree solutions

````
You can solve this exercise a great number of ways. The fastest solutions avoid constructing new strings unless they have to and instead return one of several statically allocated strings. Simpler or more flexible solutions construct strings through concatenation.

The example solutions below are roughly in run time order (fastest first), but all of them are satisfactory solutions to the problem. If you're a performance enthusiast, you can see [Luapulu's Solution](https://exercism.io/tracks/julia/exercises/raindrops/solutions/00c5eeb0e6b84b0c98a1e31ccaaca821) for benchmark results :)

## Fast solutions

### if / else

```julia
function raindrops(number)
    f3 = number % 3 == 0
    f5 = number % 5 == 0
    f7 = number % 7 == 0

    if f3
        if f5
            if f7
                "PlingPlangPlong"
            else
                "PlingPlang"
            end
        else
            if f7
                "PlingPlong"
            else
                "Pling"
            end
        end
    else
        if f5
            if f7
                "PlangPlong"
            else
                "Plang"
            end
        else
            if f7
                "Plong"
            else
                string(number)
            end
        end
    end
end
```

### Switch

A slightly slower version formatted as a single switch rather than a tree.

```julia
function raindrops(number)
    f3 = number % 3 == 0
    f5 = number % 5 == 0
    f7 = number % 7 == 0

    if f3 & f5 & f7
        "PlingPlangPlong"
    elseif f3 & f5 & !f7
        "PlingPlang"
    elseif f3 & !f5 & f7
        "PlingPlong"
    elseif f3 & !f5 & !f7
        "Pling"
    elseif !f3 & f5 & f7
        "PlangPlong"
    elseif !f3 & f5 & !f7
        "Plang"
    elseif !f3 & !f5 & f7
        "Plong"
    else
        string(number)
    end
end
```


### Lookup

You can also use a lookup table, though this is slower than both the switch and if/else tree.

```julia
function raindrops(number)
    i = 0
    i |= (number % 3 == 0)       # 001
    i |= (number % 5 == 0) << 1  # 010
    i |= (number % 7 == 0) << 2  # 100

    if i == 0
        return string(number)
    else
        return @inbounds (
            "Pling",            # 001
            "Plang",            # 010
            "PlingPlang",       # 011
            "Plong",            # 100
            "PlingPlong",       # 101
            "PlangPlong",       # 110
            "PlingPlangPlong",  # 111
        )[i]
    end
end
```

## More readable but slower solutions

These solutions are slower but make use of concatentaion so as to be more concise, readable or extendable.

### Fast and concise

This is slower than any of the fast solutions, but not by much.

```julia
function raindrops(number)
    s = ""
    
    # The '=' rather than '*=' improves performance a lot!
    number % 3 == 0 && (s = "Pling")
    number % 5 == 0 && (s *= "Plang")
    number % 7 == 0 && (s *= "Plong")

    isempty(s) && (s = string(number))

    return s
end
```

## Extendable

[cmcaine's solution](https://exercism.io/tracks/julia/exercises/raindrops/solutions/d558034438c64bb9a949f90cfcdaad6a)

A solution (over?)designed to be easily extended or changed if the `noises` spec changed. Some similar solutions use a `Dict` rather than a tuple, but a tuple of pairs is simpler and more efficient if you do not want to look up values by key.

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

## IOBuffer

Using an `IOBuffer`, as in the following example, is one of the slowest available solutions. Although this pattern is common for creating strings on the fly in julia, it's very slow in this case.

```julia
function raindrops(number)
    buf = IOBuffer(sizehint=15)

    number % 3 == 0 && write(buf, "Pling")
    number % 5 == 0 && write(buf, "Plang")
    number % 7 == 0 && write(buf, "Plong")

    s = String(take!(buf))

    if isempty(s)
        return string(number)
    else
        return s
    end
end
```
