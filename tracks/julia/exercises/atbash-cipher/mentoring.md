## Advice

- Instead of writing out the whole alphabet, you can use a character range \``'a':'z'`\`, if you like.
- \``Iterators.partition`\` and `join` might be helpful for adding spaces between groups.
- Think about what happens to non-ascii input. What would you like to happen?

The reverse index into an array is given by

```julia
length(arr) - idx
```

Because alphabet characters are ordered in unicode, we can just do this with arithmetic:

```julia
idx = char - 'a' + 1
reverseidx = 26 - idx
newchar = 'a' + reverseidx
```

This works because a `Char` + an `Int` gives a new `Char` and a `Char` subtracted from another `Char` gives the number of codepoints between them. So `'c' - 'a' == 2` and `'a' + 2 == 'c'`.

We can simplify the code a little:

```julia
26 - (c - 'a' + 1) + 'a'
# Or, simplified again
25 - (c - 'a') + 'a'
# Or, simplified again (moving the first 'a' into the 25):
('z' - c) + 'a'
```


## Example solutions

````
fleimgruber's solution:

```julia
isrelevant(c) = c in 'a':'z' || c in '0':'9'

function atbash(c)
    if !(c in 'a':'z')
        return c
    end
    return 26 - (c - 'a' + 1) + 'a'
end

function encode(input)
    lowerinput = lowercase(input)
    relevant = filter(isrelevant, lowerinput)
    encoded = map(atbash, relevant)
    return strip(replace(encoded, r".{5}" => s"\g<0> "))
end

function decode(input)
    decoded = map(atbash, input)
    return replace(decoded, r"\s+" => s"")
end
```
````


````
[OTDE's solution](https://exercism.io/tracks/julia/exercises/atbash-cipher/solutions/330cb9e444c2403c898275e71da07caa):

```julia
function encode(input::String)
    code = join(encode(char) for char in lowercase(input) if char in 'a':'z' || isdigit(char))
    return join((join(block) for block in Iterators.partition(code, 5)), ' ')
end

encode(input::Char) = isletter(input) ? 'a' + ('z' - input) : input

decode(input) = join(encode(char) for char in input if !isspace(char))
```
````

````
[halfdan's solution](https://exercism.io/tracks/julia/exercises/atbash-cipher/solutions/419b6f4d04974a63b7f8531e8ad2808c):

```julia
encode(input) = atbash(input, group=true)
decode(input) = atbash(input, group=false)

function atbash(input::AbstractString; group::Bool=false)
    input = [c for c in input if !(isspace(c) || ispunct(c))]
    result = join(map(atbash, input))
    if group
        join(map(join, Iterators.partition(result, 5)), ' ')
    else
        join(result)
    end
end

function atbash(c::Char)
    isletter(c) || return c
    'z' - (lowercase(c) - 'a')
end
```

````
[miguelraz and ScottPJones' solution](https://exercism.io/tracks/julia/exercises/atbash-cipher/solutions/037a4f733e734097a37b3287e84be40f). This performance-minded solution avoids any unnecessary memory allocation:

```julia
function decode(input::AbstractString)
    input == "" && return ""
    # This IOBuffer is for performance
    # Write it to the IO first,
    # Then make the string.
    io = IOBuffer()
    for ch in input
        if 'a' <= ch <= 'z'
            write(io, 'a' + ('z' - ch))
        elseif '0' <= ch <= '9'
            write(io, ch)
        end
    end
    String(take!(io))
end

function encode(input::AbstractString)
    # Check for empty strings always
    input == "" && return ""
    io = IOBuffer()
    count = 0
    for ch in input
        if 'a' <= ch <= 'z'
            write(io, 'a' + ('z' - ch))
        elseif 'A' <= ch <= 'Z'
            write(io, 'a' + ('Z' - ch))
        elseif '0' <= ch <= '9'
            write(io, ch)
        else
            continue # ignore the punctuation and nonintersting chars
        end
        # Take care to write out the spaces
        count += 1
        if count % 5 == 0
            write(io, ' ')
        end
    end
    # Outside of the loop, make sure not to include an extra space char
    if count % 5 == 0
        String(take!(io))[1:end-1]
    else
        String(take!(io))
    end
end
```
````
