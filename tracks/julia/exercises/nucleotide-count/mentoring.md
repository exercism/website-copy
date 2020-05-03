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

If single-core speed is of the essence, a pattern like this may perform better.

```julia
function count_nucleotides(strand)
    ca = cc = cg = ct = 0
    for nuc in strand
        if nuc == 'A'
            ca += 1
        elseif nuc == 'C'
            cc += 1
        elseif nuc == 'G'
            cg += 1
        elseif nuc == 'T'
            ct += 1
        else
            throw(DomainError(nuc, "only A, C, G and T are valid nucleotides"))
        end
    end
    return Dict('A' => ca, 'C' => cc, 'G' => cg, 'T' => ct)
end
```

While this solution is easy to make threaded or parallel by e.g. replacing `count` with `ThreadsX.count()`

```julia
function count_nucleotides(strand)
    counts = Dict(base => count(==(base), strand) for base in "ACGT")
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
