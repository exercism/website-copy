# Mentoring

## Common comments

- You might not know that repeatedly concatenating strings like this causes a lot of strings to be allocated (they are not appended in place). If you want to avoid that you can use an `IOBuffer` or (less efficiently) a vector of `Char`.
- Using `isnumeric` is safe here because the input is defined quite restrictively, but in general it is not a good idea if what you really mean is `'0' <= c <= '9'` because `isnumeric` matches a lot more characters, e.g. `¾` or `௰`, and is a lot slower. `isdigit` is a safe alternative.


## Example solutions

````
[blainne's solution](https://exercism.io/tracks/julia/exercises/run-length-encoding/solutions/bea95290808c4974bc950a41b4e19f93)

```julia
function encode(s)
    s == "" && return ""
    current = s[begin]
    count = 0
    iobuffer = IOBuffer()

    for c in s
        if current == c
            count = count + 1
        elseif current != c
            write(iobuffer, printcount(count), current)
            count = 1
            current = c
        end
    end
    write(iobuffer, printcount(count), current)

    String(take!(iobuffer))
end

printcount(count) = count == 1 ? "" : string(count)

function decode(s)
    iobuffer = IOBuffer()
    digitbuffer = IOBuffer()

    for c in s
        if isdigit(c)
            write(digitbuffer, c)
        else
            write(iobuffer, repeat(digitbuffer, c))
        end
    end

    String(take!(iobuffer))
end

function repeat(digitbuffer::IOBuffer, char)
    number = String(take!(digitbuffer))
    count = number == "" ? 1 : parse(Int32, number)
    Base.repeat(char, count)
end
```

mandos9's solution

```julia
function encode(s)
    counts = foldl(folding, s; init = [])

    s = ""
    for (c, count) in counts
        if count == 1
            s = string(s, c)
        else
            s = string(s, count, c)
        end
    end
    s
end


function folding(agg, c)
    if isempty(agg)
        push!(agg, (c, 1))
    else
        last, count = pop!(agg)
        if c == last
            push!(agg, (last, count+1))
        else
            push!(agg, (last, count))
            push!(agg, (c, 1))
        end
    end
end


function decode(s)
    num = ""
    res = ""
    for c in s
        if isnumeric(c)
            num = string(num, c)
        else
            if isempty(num)
                res = res * c
            else
                res = res * repeat(c, parse(Int, num))
                num = ""
            end
        end
    end
    res
end
```
````
