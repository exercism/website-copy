### Mentor guidance

Students that use four counting variables rather than mutating a dict should be shown the dict solution or asked to come up with it on their own if there is some doubt that they knew they could do that.

We shouldn't require the mutating-a-dict strategy because it's actually pretty slow.


### Example solutions

Straightforward solution. Easily understood, but quite slow because it will compute the hash of a character twice on each iteration.

````
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
````

We can get some speedup with a simple stack of if/elseifs like this:

````
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
````

While this solution is easy to make threaded or parallel by e.g. replacing `count` with `ThreadsX.count()`:

````
```julia
function count_nucleotides(strand)
    counts = Dict(base => count(==(base), strand) for base in "ACGT")
    if sum(values(counts)) != length(strand)
        throw(DomainError(strand, "only A, C, G and T are valid nucleotides"))
    end
    counts
end
```
````

This solution, though perhaps a little harder to understand, is much faster at the price of just a little memory use:

````
```julia
function count_nucleotides(strand)
    utf8 = transcode(UInt8, strand)
    counts = zeros(Int, 256)
    for byte in utf8
        @inbounds counts[byte + 1] += 1
    end
    result = Dict(base => counts[Int(base) + 1] for base in "ACGT")
    if sum(values(result)) != length(utf8)
        throw(DomainError(strand, "only A, C, G and T are valid nucleotides"))
    end
    result
end
```
````

### Common suggestions

(Formatted so you can copy and paste easily)

- Btw, you can initialise the Dict with a generator, if you like: \`Dict(base => 0 for base in "ACGT")\`
- In Julia, the properties of objects are generally considered private unless documented otherwise, so we generally prefer \`value in keys(dict)\` or \`haskey(dict, value)\` over \`value in dict.keys\`
