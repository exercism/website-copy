# Mentoring

## Problem and Challenges

The problem asks you to classify a number as one of perfect, abundant, or deficient.

## Reasonable Solution

```python
def classify(number: int) -> str:
    if number <= 0:
        raise ValueError("Bad input")

    aliquot = sum(i for i in range(1, number) if number % i == 0)
    if aliquot == number:
        return "perfect"
    if aliquot > number:
        return "abundant"
    return "deficient"
```

## Talking Points

### Optimizations

A simple optimization is to use `range(1, number // 2 + 1)` in the `for` loop. This halves the complexity.

For a more efficient solution, one can compute all the factors by iterating over the smaller set, `range(1, int(math.sqrt(number)) + 1)`.
This solution is longer and more involved but significantly faster, reducing the cost from `O(n)` to O(sqrt(n))`.

```python
def classify(number: int) -> str:
    ...
    factors = set()
    for i in range(1, int(math.sqrt(number)) + 1):
        if number % i != 0:
            continue
        factors.add(i)
        factors.add(number // i)
    factors.remove(number)
    aliquot = sum(factors)
    ...
```

### Points to call out

Students unfamiliar with generator expressions might write: `aliquot = sum([i for i in range(1, number) if number % i == 0])`.
Note this (1) iterates over the range to create a list of factors then (2) iterates over the list to sum the values.
Dropping the `[]` allows `sum()` to iterate directly over a generator and only requires a single iteration.
