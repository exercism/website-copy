# Mentoring

## Mentor guidance

- A n^3 solution is trivial to find, but too slow for the tests. An n^2 solution is pretty easy to find. A O(n) solution requires solving some simultaneous equations.
- We should require students to find an n^2 solution at least.

## Example solutions

````
There are three reasonably common solutions to this problem, a cubic time solution, a quadratic time solution and a linear time solution
(if those terms are unclear to you, you might like to read about [time complexity](https://en.wikipedia.org/wiki/Time_complexity)).

__Cubic time solution__

Just iterate over a, b, and c.
This solution is very simple, but really is too slow.
So much so that the tests are unlikely to run in a reasonable time :)

```julia
"""
    pythagorean_triplets(n)

Find all positive integer triplets `(a, b, c)` s.t. `a + b + c = n` and
`a < b < c` and `a^2 + b^2 == c^2`.
"""
function pythagorean_triplets(n)
    triplets = []
    for a in 1:n
        for b in a+1:n
            for c in b+1:n
                a^2 + b^2 == c^2 && push!(triplets, (a, b, c))
            end
        end
    end
    return triplets
end
```


__Quadratic time algorithm__

```julia
"""
    pythagorean_triplets(n)

Find all positive integer triplets `(a, b, c)` s.t. `a + b + c = n` and
`a < b < c` and `a^2 + b^2 == c^2`.
"""
function pythagorean_triplets(n)
    triplets = NTuple{3, Int}[]
    for a in 1:n
        for b in a+1:n
            c = n - a - b
            b < c && a^2 + b^2 == c^2 && push!(triplets, (a, b, c))
        end
    end
    return triplets
end
```

Calculating `c` from `a` and `b` clearly eliminates a huge number of iterations making this significantly faster than the previous solution.

We have also told Julia the type of `triplets` in this version.
Without an annotation Julia will type `triplets` as `Vector{Any}`, which means a vector of pointers to heap-allocated objects.
Annotating with an immutable type, which by definition will be of known size,
[allows Julia to simply store the items one after the other without indirection](https://docs.julialang.org/en/v1/manual/performance-tips/index.html#man-performance-abstract-container).

This will make almost no difference to the speed of this particular function because the number of `push!`s are very small compared to other operations,
but it would help _type inference_ in functions using the output of `pythagorean_triplets(x)`, which is often useful.

We can improve this solution slightly by tightening up the loop bounds using some simple arithmetic and floor division (`fld`):

```julia
    # Lower bound because the smallest triple is 3, 4, 5.
    # Upper bounds implied by a < b < c && a + b + c == n.
    for a in 3:fld(n, 3)-1
        for b in a+1:fld(n, 2)-1
```

> Note: you can come up with even tighter bounds than these. Share your working with your mentor if you do!

The intuition on upper bounds is that if we were working with real numbers, the biggest `a` can be is `n/3 - ε`,
where `ε` is the smallest real number greater than 0,
because `b` and `c` must both be larger.
Similarly, the biggest `b` can be is `n/2 - ε` because `c` must be larger than it.

When we move that to the integers, we observe that the maximum remainder of `n/3` is 2.
We already know that the biggest `a` can be is  when `a`, `b`, and `c` are as close as possible, so that gives us something like this: `fld(n, 3) - 1 < fld(n, 3) + x < fld(n, 3) + y` where `x < y && -1 + x + y < 2`.
Similarly, the biggest remainder of `n/2` is 1, so the largest `b` can be is when our variables are `1 < fld(n, 2) - 1 < fld(n, 2) + 1`, so an upper bound on `b` is `fld(n, 2) - 1`.


__Linear time algorithm__

To really go fast, we need a linear time algorithm, and this one derived by solving some simultaneous equations is a much greater improvement:

```julia
"""
    pythagorean_triplets(n)

Find all positive integer triplets `(a, b, c)` s.t. `a + b + c = n` and
`a < b < c` and `a^2 + b^2 == c^2`.
"""
# cmcaine's answer, with thanks to akshu3398.
function pythagorean_triplets(n)
    triplets = NTuple{3, Int}[]
    # Lower bound because the smallest triple is 3, 4, 5.
    # Upper bound implied by a < b < c && a + b + c == n.
    for a in 3:fld(n, 3)-1
        # Derived by eliminating c from these simultaneous
        # equations and solving for b:
        #     a^2 + b^2 = c^2
        #     a + b + c = n
        b = (n^2 - 2n * a) / (2 * (n - a))
        if a < b && isinteger(b)
            c = n - a - b
            # Proof that b < c:
            # Let b = c. Then a^2 + b^2 = c^2 ≡ a^2 = 0 but we know that a ≠ 0.
            # Let b > c. a^2 + b^2 = c^2 ≡ a^2 = c^2 - b^2.
            #    If b > c, a^2 < 0, but that is impossible for real numbers.
            push!(triplets, (a, b, c))
        end
    end
    return triplets
end
```

If you use some mathematics or algebraic rearrangements that are not entirely trivial
then it's often a good idea to document explicitly what you have done so that other programmers (including future you!) can follow your argument.
What seems obvious to you may not be to others and vice versa.

Attentive readers may notice that `b` and `c` are `Float64` and yet are being inserted into a tuple of `Int`s.
Julia will silently convert values between types when it is safe to do so.
When converting from a floating point type to an int, this generally means that a runtime error will be thrown if the float has a fractional part or if it is too large.

We could reduce the number of `Float64 -> Int` conversions by one by defining `c` like this:

```julia
c = n - a - Int(b)
```
````
