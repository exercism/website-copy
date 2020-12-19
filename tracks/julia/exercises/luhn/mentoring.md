## General advice

- Luhn IDs require at least two digits, not just any two characters.
- for loops are fine in Julia. Write for loops :)
- You can efficiently collect a string into a vector of characters and filter it at the same time with an array comprehension
- If you want a vector of characters from a string, `collect(str)` is the simplest way to get one.
- Think about allocations. How many collections (strings, vectors) do you need to allocate? 2? 1? 0?

## Example solutions

A good docstring will look something like this:

```julia
"""
    luhn(str)

Return true if `str` encodes a valid number in the luhn formula.

A valid string will:

 - Contain only numbers and space
 - Contain at least two numbers
 - After a transformation, the sum of the transformed digits will be evenly divisible by 10

The transformation is:

 - Every second digit, counting the rightmost digit as first, is doubled
 - If a doubled digit is greater than 9, subtract 9 from it.
"""
```


**Iterate backwards**

The simplest way to solve this exercise is to just iterate over the string backwards:

```julia
function luhn1(str)
    acc = 0
    len = 0
    for chr in Iterators.reverse(str)
        if isdigit(chr)
            len += 1
            x = parse(Int, chr)
            acc += iseven(len) ? (2x < 10 ? 2x : 2x-9) : x
        elseif chr != ' '
            return false
        end
    end
    len > 1 ? acc % 10 == 0 : false
end
```

This solution uses `Iterators.reverse` instead of `reverse` to avoid allocating
a new reversed string, but either would work.

We're also using juxtaposition multiplication, which is a fancy way of saying that `2x` is equivalent to `2 * x`.

As with most exercises involving strings, a lot of time is spent doing unicode-aware things.
So we can speed it up if we avoid those things.

For example, when parsing `chr`, we already know that it is a digit, so we can just do some arithmetic:

```julia
# Old version
x = parse(Int, chr)

# ~40% faster:
x = chr - '0'
```

And, with a little work, we can rewrite the whole solution to operate on bytes for a 25x speedup:

```julia
# 25x faster by iterating the utf8 bytes rather than the string
# This is still unicode-safe.
function luhn2(str)
    acc = 0
    len = 0
    for byte in Iterators.reverse(transcode(UInt8, str))
        x = byte - UInt8('0')
        if 0 <= byte < 10
            len += 1
            acc += iseven(len) ? (2x < 10 ? 2x : 2x-9) : x
        elseif byte != UInt8(' ')
            return false
        end
    end
    len > 1 ? acc % 10 == 0 : false
end
```


**Break it up**

A different approach might break the problem up into a few different steps, like this:

```julia
function luhn3(str)
    all(chr -> isdigit(chr) || chr == ' ', str) || return false

    ds = [parse(Int, chr) for chr in str if isdigit(chr)]

    length(ds) > 1 || return false

    for i in length(ds)-1:-2:1
        ds[i] *= 2
        if ds[i] > 10
            ds[i] -= 9
        end
    end

    sum(ds) % 10 == 0
end
```

The steps are:

- check that the string only contains digits and spaces,
- construct a vector of all the digits
- check that we have at least two
- apply the transformation to every second digit (counting from the back)
- finally, check if the sum is divisible by 10.

This solution is fine, though it is a bit slower than the others above.

If you've written what this author would refer to as "too much R", you might replace the for loop with these two broadcast expressions:

```julia
ds[end-1:-2:1] .*= 2
ds[ds .> 10] .-= 9
```

Which is correct, but a bit slow :)


**The perils of strings**

You might be tempted to do something like this:

```
str = replace(str, ' ' => "")
all(isdigit, str) || return false

ds = parse.(Int, collect(str))

# ...
```

You can get the right answer, but this way you'll end up allocating two collections: a new string and a vector of integer digits.
It's faster to only allocate one collection and fastest to allocate zero :)
