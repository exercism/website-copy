## Mentoring suggestions

- Unrolled solutions are fine, don't require that students use loops or reduction or whatever.
- Prefer a tuple or vector of pairs to a Dict. There's no need to add values to the Dict or lookup items by key, so a simpler container is better.
- If performance matters, constructing strings is slow! Profiling shows that `string(number)` and string concatenation are the biggest time sinks. Branching / lookup and remainder calculation are blazingly fast by comparison.

````
You can solve this exercise a great number of ways!
The fastest solutions avoid constructing new strings unless they have to and instead return one of several statically allocated strings when `n` is divisible by 3, 5, or 7.
Simpler or more flexible solutions construct strings through concatenation.

The example solutions below are roughly in run time order (fastest first), but all of them are satisfactory solutions to the problem.
If you're a performance enthusiast, you might like to check out the benchmarking notes below because it's easy to measure the wrong thing.

<details>
<summary>Aside: benchmarking raindrops</summary>

When benchmarking code, we generally take the minimum time from several runs of the code.
We can do that with:

```julia
using BenchmarkTools

# Thing we want to benchmark
foo(x) = x * x + x

# Benchmark a specific value
# Wrapped in $() to stop the compiler cheating
@btime foo($(100))

# Benchmark on some randomly selected small integers
@btime foo(v) setup=(v = rand(1:1000))
```

That's a good default, but if you supply a random value as input to a function that takes a very different amount of time per value (as several of the solutions below do), then the minimum will be the time of the "happy path", rather than a time that represents the time taken for a randomly selected input value.

If you're interested in the average time, but still want to avoid issues with outliers, it's a good idea to apply your function to many inputs in each benchmark trial:

```julia
# One fast branch, one slow branch
bar(x) = x < 10 ? 10 : log(x)

# Tell us the minimum time it takes to call `bar` once on each of 1:1000.
@btime foreach(bar, $(1:1000))

# If the benchmark is suspiciously quick, the compiler could be eliding the for loop.
# In that case you can force it to do the work with a simple reduction.
@btime mapreduce(bar, (a, b) -> b, $(1:1000)) # A do-nothing reduction
@btime maximum(bar, $(1:1000))
```

If you want to benchmark lots of variants of the same function, you can define them as `raindrops1`, `raindrops2`, etc. and do some simple code generation like this:

```julia
julia> for i in 1:6
          print("$i: ")
          @btime foreach($(Symbol(:raindrops, i)), 1:1000)
       end
1:   23.200 μs (914 allocations: 42.84 KiB)
2:   26.630 μs (914 allocations: 42.84 KiB)
3:   26.049 μs (914 allocations: 42.84 KiB)
4:   39.234 μs (1256 allocations: 53.53 KiB)
5:   62.621 μs (1589 allocations: 63.94 KiB)
6:   99.853 μs (4457 allocations: 233.03 KiB)
```
</details>

**if / else tree**

```julia
function raindrops1(number)
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


**Lookup**

A lookup table is another good option.

```julia
function raindrops2(number)
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


**Switch**

A slightly slower version formatted as a single switch rather than a tree of ifs.

```julia
function raindrops3(number)
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

The following three solutions are slower but make use of concatentaion so as to be more concise, readable or extendable.

**Compact**

This solution is short, easy to read and almost as fast in the average case as the solutions above!
It is fast because it avoids one string concatenation in the common case that `number` is divisible by 3
and when `number` is divisible by 3, but not 5 and 7, the statically allocated string "Pling" is returned almost instantly.

```julia
function raindrops4(number)
    s = ""
    # The first equals here lets us avoid
    # dynamically allocating a string in the
    # case that number is only divisible by 3.
    number % 3 == 0 && (s = "Pling")
    number % 5 == 0 && (s *= "Plang")
    number % 7 == 0 && (s *= "Plong")
    isempty(s) && (s = string(number))
    return s
end
```

Try changing `s = "Pling"` to `s *= "Pling"` and benchmarking with 3, 14, and 15 to see what's going on.

<details>
<summary>Expected benchmark results and explanation</summary>

raindrops3a is the version with `s *= "Pling"`.

```julia
using BenchmarkTools

@btime raindrops4($(3))         # 0 allocations
@btime raindrops4a($(3))        # 1 allocation

# 14 is not divisible by 3, so there's no difference here.
@btime raindrops4($(14))        # 1 allocation
@btime raindrops4a($(14))       # 1 allocation

# 15 is divisible by 3 and 5 and we can still avoid the first allocation.
@btime raindrops4($(15))        # 1 allocation
@btime raindrops4a($(15))       # 2 allocations
```
</details>


**Extendable**

[cmcaine's solution](https://exercism.io/tracks/julia/exercises/raindrops/solutions/d558034438c64bb9a949f90cfcdaad6a)

A solution (over?)designed to be easily extended or changed if the `noises` spec changed. Some similar solutions use a `Dict` rather than a tuple, but a tuple of pairs is simpler and more efficient if you do not want to look up values by key.

```julia
function raindrops5(n)
    noises = (3 => "Pling", 5 => "Plang", 7 => "Plong")
    acc = ""
    for (factor, noise) in noises
        n % factor == 0 && (acc *= noise)
    end
    isempty(acc) ? string(n) : acc
end
```

**IOBuffer**

Using an `IOBuffer` to create a string on the fly is a common pattern in julia. However, in this case, it tends to be rather slow compared to the other solutions.

```julia
function raindrops6(number)
    buf = IOBuffer(sizehint=15)

    number % 3 == 0 && write(buf, "Pling")
    number % 5 == 0 && write(buf, "Plang")
    number % 7 == 0 && write(buf, "Plong")

    if position(buf) == 0
        return string(number)
    else
        return String(take!(buf))
    end
end
```
