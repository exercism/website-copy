# Mentoring

## Common suggestions

- Good job thinking in terms of set relationships! You can express this as a single relationship, though. Can you work out which?
- Instead of writing out the whole alphabet, you can use a character range \``'a':'z'`\`, if you like.


## Example solutions

A simple, elegant solution:

````
```julia
ispangram(input) = 'a':'z' ⊆ lowercase(input)
```
````

⊆ can be entered at the Julia repl as \``\subseteq`\` followed by tab. It's the infix operator for the \``issubset`\` function.

Two more simple solutions:

The first uses function currying, which may look strange at first, but is very convenient for predicates like \``in`\`.
The second uses an anonymous function and avoids taking a copy of the input to reduce memory usage.

````
```julia
ispangram1(input) = all(in(lowercase(input)), 'a':'z')

ispangram2(input) = all(c -> in(c, input) || in(uppercase(c), input), 'a':'z')
```
````

And here's a faster, more complicated solution,
just in case pangram-identification is on the critical path for your new startup.
Speed comes from avoiding expensive unicode-compatible iteration and upper/lowercasing and
from keeping the body of the loop very simple (no conditionals, minimal logic).

This is still unicode safe, if you don't understand why, the wikipedia article on UTF-8 might help :)

````
```julia
function ispangram3(input)
    utf8 = transcode(UInt8, input)
    present = zeros(Bool, 256)
    @inbounds for byte in utf8
        # byte | 0x20 will make uppercase ASCII into lowercase ASCII.
        # Other characters will be mangled, but we don't care about that.
        present[(byte | 0x20) + 1] = true
    end
    all(present[char + 1] for char in UInt8('a'):UInt8('z'))
end
```
````
