# Mentoring

## Problem and Challenges

The problem asks you to translate an RNA string to a DNA string.
This is a basic string translation problem.

## Reasonable Solution

```python
translation = {"G": "C", "C": "G", "T": "A", "A": "U"}


def to_rna(dna_strand: str) -> str:
    return "".join(translation[i] for i in dna_strand)
```

## Talking Points

### Translation Methods

Common approaches to translating the strand include: a dictionary,
`str.translate()`, and an `if-elif` chain.

Dictionaries are the most common and simple. They work well.

[`str.translate()`](https://docs.python.org/3/library/stdtypes.html#str.translate)
is a bit more esoteric and should use
[`str.maketrans()`](https://docs.python.org/3/library/stdtypes.html#str.maketrans)
to form the translation map. This is less common but also a good solution.
`str.translate()` should not be used without `str.maketrans()`. The developer
should not need to use an ASCII table to read or modify the code.

In either of the prior two cases, the translation mapping should be created
once at the module level as a constant rather than created every time the
function is called; there is no reason to recreate the mapping anew for every
function call.

An `if-elif` chain is repetitive and cumbersome. It is a more obvious solution
when someone is not as familiar with mappings like a dictionary. It mixes the
control flow and the data (translation map), making the code more cumbersome
and more difficult to manage. It should be discouraged.

Here are some comments that can be copy/pasted/edited to address some of these
points:

```Text
For a more compact and less repetitive solution you can build a translation map (typically done with a `dict` though [`str.maketrans()`](https://docs.python.org/3/library/stdtypes.html#str.maketrans) is also an option). That way you don't need to have another `if` for each letter.
The translation dict is a good candidate for a module-level constant. There is not need to have it recreated every time the function is called.
Python is a pretty high level language with all sorts of string support. Can you come up with a solution that doesn't require someone pull out an ASCII table to read/modify?
```

### String Building

This exercise involves building a string which is returned. The string may end
up being rather large. Since strings are immutable in Python, every time a
string append is done, Python needs to create a new string object and discard
the old string object. This can get expensive when the string is large and/or
the append is done many times. Instead, a `list` and `str.join` should be used;
`list` appends are cheaper in the long run.

List comprehensions are much more familiar than generators to many people.
However, building a `list` is an extra step that is not needed. It requires
creating an extra copy of the data which is promptly discarded. Using a
generator bypasses that step.

Here are some comments that can be copy/pasted/edited to address some of these
points:

```Text
Every time you do a string append, Python has to create a brand new string and discard the old string. This isn't a big deal when it's a small string or a small number of appends. However, when you do this a lot of times with a larger string, it can get expensive. Appending to an array, on the other hand, is relatively cheap. You can use an array to build a string by parts then something like `"\n".join(parts)` or `"".join(parts)` to combine them (using a more descriptive variable name than `parts` ideally).
`[f(a) for a in b]` iterates through `b` to create a list. You are then passing this list to `str.join()` which iterates through that list to build a string and discards that list. You can avoid that extra middle step of building and storing a list by passing a generator to `str.join()` instead and having `str.join()` process the elements of that iterator directly! You can do this either by doing `str.join(f(a) for a in b)` or `generator = (f(a) for a in b); str.join(generator)`
```

### Final Suggestions

Once everything else looks good, you can suggest some things to clean up the
code, such as type annotations.

Here are some comments that can be copy/pasted/edited to address some of these
points:

```Text
If you want to go the extra step, type annotation is worth adding to your code!
```
