# Mentoring

## Mentor guidance

We want them to realise that they can define two methods for `rotate`.

The metaprogramming is quite challenging for lots of students. Consider offering to just show them the answer: "The metaprogramming is a bit hard to understand at first, would you like me to show you that part of the answer?"


## Example solution

````
```julia
"""
    rotate(n, c::AbstractChar)

Rotate `c` `n` places if it is an ASCII letter, else return it

"""
function rotate(n, c::AbstractChar)
    if c in 'a':'z'
        'a' + (c - 'a' + n) % 26
    elseif c in 'A':'Z'
        'A' + (c - 'A' + n) % 26
    else
        c
    end
end

"""
    rotate(n, itr)

Rotate each ASCII alphabetic character in iterable `n` places

"""
rotate(n, itr) = map(c -> rotate(n, c), itr)
```

Breakdown of `'a' + (c - 'a' + n) % 26`:

This works because:

1. subtracting one character from another gives the distance between them as an `Int`
1. adding an `Integer` to a `Char` returns a `Char` shifted by the integer

```
(c - 'a' + n)
└──┬───┘
   └─ returns the "distance" between both characters in the alphabet as an Int (e.g. `'b' - 'a' == 1`).
```

```
'a' + (c - 'a' + n) % 26
└┬┘   └────────┬───────┘
 │             └─ returns an Int that specifies how much the
 │                character needs to be shifted compared to
 │                the beginning of the alphabet ('a').
 └─ The beginning/base of the alphabet.
```
````

Metaprogramming bit:

Just R13:

````
```julia
macro R13_str(s)
    rotate(13, s)
end
```
````

All of the macros done with a for loop:

````
```julia
for n in 0:26
    @eval macro $(Symbol(:R, n, :_str))(s)
        rotate($n, s)
    end
end
```
````


## Common suggestions

(Formatted so you can copy and paste easily)

- The metaprogramming is a bit hard to understand at first, would you like me to show you that part of the answer?
- It's often useful to break a problem down into smaller parts. Perhaps you'd like to start with this?

````
```julia
"Explain what this method does here"
function rotate(n, c::Char)
    ...
end

"Explain what this method does here"
function rotate(n, str)
    ...
end
```
````


## Talking points

- Iterating a string is slow because it's a variable length encoding. If you're iterating something with elements of a fixed size (a vector of UInt8s or an ASCIIStr (Strs.jl), perhaps), this can be faster.
