# Mentoring

## Common suggestions

- Perhaps this would be better with bitwise operators? Have you tried that yet?
- You can save some allocations if you use a tuple rather than a vector. If you would like to do that, just swap those [] for ().
- \``reverse!`\` is an in-place variant on \``reverse`\` that you might prefer to use to reduce allocations.


## Example solution

````
pdb5627's solution (slightly edited)

This short and simple solution is fast, extremely easy to read, and clearly demonstrates the bitwise operations that most solutions use.
Four of the lines are obviously very similar to each other and it's totally fine to write code that is "unrolled" like this.

```julia
function secret_handshake(n)
    s = String[]
    n & 1 > 0 && push!(s, "wink")
    n & 2 > 0 && push!(s, "double blink")
    n & 4 > 0 && push!(s, "close your eyes")
    n & 8 > 0 && push!(s, "jump")
    n & 16 > 0 && reverse!(s)
    return s
end
```

cmcaine's solution

```julia
function secret_handshake(code)
    cipher = (
        0b0001 => "wink",
        0b0010 => "double blink",
        0b0100 => "close your eyes",
        0b1000 => "jump",
    )

    res = [part for (mask, part) in cipher if code & mask != 0]
    (code & 0b10000 != 0) && reverse!(res)

    return res
end
```
````

````
cmcaine's solution, with a table lookup.

This is unnecessarily fast, but I wanted to introduce the idea and emphasise that the domain of this function is very small, so it is quite practical to just store every output.

```julia
function _secret_handshake(code)
    cipher = (
        0b0001 => "wink",
        0b0010 => "double blink",
        0b0100 => "close your eyes",
        0b1000 => "jump",
    )

    res = [part for (mask, part) in cipher if code & mask != 0]
    (code & 0b10000 != 0) && reverse!(res)

    return res
end

# Memoize
const HANDSHAKES = [_secret_handshake(code) for code in 0:0b11111]

# If we were allowed to return tuples, we wouldn't need the copy()
secret_handshake(code) = copy(HANDSHAKES[(code & 0b11111) + 1])
```
````

Some interesting solutions showing some Julia functions and features students
may not be aware of:

````
gevis' solution, showing logical indexing and broadcasting.
They could also have used `digits(Bool, n; base=2, pad=5)` and avoided the broadcast.

```julia
function secret_handshake(n::Integer)
    codes = ["wink", "double blink", "close your eyes", "jump"]
    f = isone.(digits(n, base=2, pad=5))
    handshake = codes[f[1:4]]
    f[5] ? reverse(handshake) : handshake
end
```
````

````
Samyak's solution, with a nice, simple for loop.

Declaring `actions` as a const outside of the function avoids allocating it each time.
Samyak could have declared `actions` within the function as a tuple instead, which would give the same or better performance and avoids defining a top-level constant.

```julia
const actions = ["wink", "double blink", "close your eyes", "jump"]
function secret_handshake(code::Integer)
    sequence = String[]
    for iter in 1:4
        ((code & 1) == 1) && push!(sequence, actions[iter])
        code >>= 1
    end
    return (code & 1) == 1 ? reverse(sequence) : sequence
end
```
````
