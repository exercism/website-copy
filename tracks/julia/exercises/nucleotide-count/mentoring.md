# Mentoring

### Mentor guidance

Students that use four counting variables rather than mutating a dict should be shown the dict solution or asked to come up with it on their own if there is some doubt that they knew they could do that.

We shouldn't require the mutating-a-dict strategy because it's actually pretty slow.


### Common suggestions

(Formatted so you can copy and paste easily)

- Btw, you can initialise the Dict with a generator, if you like: \`Dict(base => 0 for base in "ACGT")\`
- In Julia, the properties of objects are generally considered private unless documented otherwise, so we generally prefer \`value in keys(dict)\` or \`haskey(dict, value)\` over \`value in dict.keys\`


### Example solutions

Straightforward solution. Easily understood, but a bit slow because it will compute the hash of a character twice on each iteration (though any of these solutions is plenty fast enough for even pretty large inputs!).

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

We can get some speedup with a simple stack of if/elseifs like this:

```julia
function count_nucleotides2(strand)
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

While this solution is easy to make threaded or parallel by e.g. replacing `count` with `ThreadsX.count()`:

```julia
function count_nucleotides3(strand)
    counts = Dict((base => count(==(base), strand)) for base in "ACGT")
    if sum(values(counts)) != length(strand)
        throw(DomainError(strand, "only A, C, G and T are valid nucleotides"))
    end
    counts
end
```

It can be surprising to some people that this solution using `count(==(base), strand)` iterates `strand` 4 times and is about as fast (or faster) as the solutions above that iterate `strand` only once.
This is because the complexity of your loop body matters.
In this case, we swap one iteration of a moderately complex loop body for four iterations of a very simple loop body.

This solution, though perhaps a little harder to understand, is much faster at the price of just a little memory use:

```julia
function count_nucleotides4(strand)
    utf8 = transcode(UInt8, strand)
    counts = zeros(Int, 256)
    @inbounds for byte in utf8
        counts[byte + 1] += 1
    end
    result = Dict(base => counts[Int(base) + 1] for base in "ACGT")
    if sum(values(result)) != length(utf8)
        throw(DomainError(strand, "only A, C, G and T are valid nucleotides"))
    end
    result
end
```

Its speed comes from three sources:

1. Iterating a vector of bytes instead of characters (though this algorithm is still unicode-safe).
   This is faster because iterating characters from a `String` involves scanning the same vector of UTF-8 bytes but also doing a little work every iteration to establish if the current byte is the start of a multibyte sequence (and, if so to reassemble that sequence into its proper 32 bit character).
2. The loop body is extremely simple and fast on x86 processors (load a value, increment a value at an offset\*) and branchless (there are no conditionals within the loop body).
   Branchless code is often faster because branching hinders CPU instruction level parallelism and stops compilers using "Single Instruction Multiple Data" (SIMD) instructions (though this loop body can't benefit from SIMD anyway).
3. Bounds checks are turned off with `@inbounds`, this removes some hidden branches (normally every array access in Julia has a little check that the index is valid first).
   We can trivially prove that all indexes will be valid because a UInt8 has values ranging from 0:255 and the array we're indexing has indexes 1:256. The `+ 1` is there to make those two ranges line up.

\* If you're good enough at reading assembly or LLVM you can verify this yourself with `@code_native` or `@code_llvm`. More info than you probably want:

<details>
<summary>More info than you want about assembly :D</summary>

If you were writing the inner loop for `count_nucleotides4` manually in intel syntax x86 assembly you might write something like:

```nasm
        ; Where:
        ; r14 is the address of the start of the utf8 array
        ; rbx is the address of the start of the count array
        ; rcx is the length of the utf8 array

        ; Check utf8 isn't empty
        cmp rcx rcx
        je endofloop
        ; init rdx to 0
        xor rdx rdx
countloop:
        ; Get a byte from the utf8 array
        movzx   edi, byte ptr [r14 + rdx + 8]
        ; Increment the value in the count array at offset (byte * 8)
        ; (* 8 because our array is of 64 bit ints = 8 bytes)
        inc     qword ptr [rbx + 8*rdi]
        ; Increment our index into the utf8 array
        inc     rdx
        ; If we haven't reached the end of the array yet, go again
        cmp     rcx, rdx
        jne     countloop
endofloop:
        ; ...
```

For our code above, Julia produces pretty similar results:

(I used `code_native(count_nucleotides4, (String,); syntax=:intel)` which you could read as "Show me the native code produced when compiling `count_nucleotides4` with the argument types `(String,)` (i.e. one argument that is a `String`), and show me it in Intel's assembly syntax". You could also use `@code_native count_nucleotides4("foo")` and you'll get the same stuff but in the AT&T assembly format.)

```nasm
L320:
        movzx   edx, byte ptr [r14 + rcx]
        ; Load the address of counts (I don't know why this happens
        ; repeatedly, but whatever).
        mov     rdi, qword ptr [rax]
        inc     qword ptr [rdi + 8*rdx]

        ; These next four lines are slightly more complex than they need to be
        ; because Julia isn't storing the length of the utf8 array in a register
        ; and is instead looking it up each time, but you can get Julia not to do
        ; that, and it's still very fast.
        lea     rdx, [rcx + 1]
        add     rcx, -7
        cmp     rcx, qword ptr [r14]
        mov     rcx, rdx
        jne     L320
```

You can convince Julia not to look up the utf8 array length each time with the `@simd` macro or manually with something like:

```julia
    len = length(utf8)
    @inbounds for idx in 1:len
        byte = utf8[idx]
        counts[byte + 1] += 1
    end
```

If you do, you'll get ASM output something like this:

```nasm
L288:
        movzx   edi, byte ptr [r14 + rdx + 8]
        ; Still loading the address of counts each time.
        ; Maybe there's a clever reason for that or maybe this is silly idk.
        mov     rbx, qword ptr [rax]
        inc     qword ptr [rbx + 8*rdi]
        inc     rdx
        cmp     rcx, rdx
        jne     L288
```

</details>
<br />

Finally, one neat thing is that `transcode(UInt8, strand)`, which yields a read-only vector of UTF-8 bytes from our string, is free for the `String` type because it is already encoded as UTF-8 so the compiler will not emit any code for that call. If we were given a third party string that was not UTF-8 compatible (perhaps encoded as UTF-32) then it would have to do more work and we might be better off defining a different method for that type using the `count_nucleotides2` algorithm or similar.
````
