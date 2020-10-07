## Mentor guidance

- A n^3 solution is trivial to find, but too slow for the tests. An n^2 solution is pretty easy to find. A O(n) solution requires solving some simultaneous equations.
- We should require students to find an n^2 solution at least.

## Example solutions

````
A O(n²) time algorithm:

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

Telling Julia the type of `triplets` allows it to store the values without indirection. Without an annotation some (all?) version of Julia will type `triplets` as `Vector{Any}`, which means a vector of pointers to heap-allocated objects, which is slower.
By contrast, annotating with an immutable type (which by definition will be of known size) allows Julia to simply store the items one after the other without indirection.

A small improvement is to tighten up the loop bounds using some simple arithmetic and floor division (`fld`):

```
    # Lower bound because the smallest triple is 3, 4, 5.
    # Upper bounds implied by a < b < c && a + b + c == n.
    for a in 3:fld(n, 3)
        for b in a+1:fld(2n, 3)
```

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
    for a in 3:fld(n, 3)
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
