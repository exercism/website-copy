### Mentor guidance

Students that use four counting variables rather than mutating a dict should be shown the dict solution or asked to come up with it on their own if there is some doubt that they knew they could do that.

We shouldn't require the mutating-a-dict strategy because it's actually pretty slow.


### Example solutions

```julia
function count_nucleotides(strand)
    counter = Dict(base => 0 for base in "ACGT")
    for base in strand
        if haskey(counter, base)
            counter[base] += 1
        else
            throw(DomainError(base, "only A, C, G and T are valid nucleotides"))
        end
    end
    return counter
end
```

```julia
function count_nucleotides(strand)
    counts = Dict(count(==(base), strand) for base in "ACGT")
    if sum(values(counts)) != length(strand)
        throw(DomainError(strand, "only A, C, G and T are valid nucleotides"))
    end
    counts
end
```


### Common suggestions

(Formatted so you can copy and paste easily)

- Btw, you can initialise the Dict with a generator, if you like: ``Dict(base => 0 for base in "ACGT")``
- In Julia, the properties of objects are generally considered private unless documented otherwise, so we generally prefer ``value in keys(dict)`` or ``haskey(dict, value)`` over ``value in dict.keys``
