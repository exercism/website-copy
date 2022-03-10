# Mentoring

## Problem and Challenges

The problem asks you to write a function returns all the contiguous substrings of length `n` in a given string.

## Reasonable Solution

```python
def slices(series, length):
    if length == 0:
        raise ValueError("slice length cannot be zero")
    if length < 0:
        raise ValueError("slice length cannot be negative")
    if not series:
        raise ValueError("series cannot be empty")
    if length > len(series):
        raise ValueError("slice length cannot be greater than series length")

    return [
        series[i:i + length]
        for i in range(len(series) - length + 1)
    ]
```

## Talking Points

This exercise is fairly straight forward without much variation across community solutions.

### Avoiding the use of `else`

The [guard statements][guard] are made of a series of `if` lines.
It can be tempting to use `elif` for the conditionals after the first one.
However, doing so would be an "unnecessary else after raise", as flagged by Pylint ([R1720][R1720]).

[guard]: https://en.wikipedia.org/wiki/Guard_(computer_science)
[R1720]: https://vald-phoenix.github.io/pylint-errors/plerr/errors/refactoring/R1720.html
