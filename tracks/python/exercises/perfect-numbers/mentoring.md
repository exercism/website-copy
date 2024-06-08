# Mentoring

## Problem and Challenges

The problem asks you to classify a number as perfect, abundant, or deficient.

## Reasonable Solution

```python
def classify(number):
    if number <= 0:
        raise ValueError("Classification is only possible for positive integers.")
    
    aliquot = sum(item for item in range(1, number) if number % item == 0)
    
    if aliquot == number:
        return "perfect"
    if aliquot > number:
        return "abundant"
    
    return "deficient"
```

## Talking Points

### Optimizations

A simple optimization is to use `range(1, number // 2 + 1)` as the `for` loop `iterable`.
This halves the complexity of the solution.

For a more efficient solution, one can compute all the factors by using the smaller `range(1, int(math.sqrt(number)) + 1)` as the `iterable`.
This solution is longer and more involved but significantly faster, reducing the complexity from `O(n)` (_linear_) to `O(sqrt(n))` (_square root_).

```python
def classify(number):
    ...
    factors = set()
    for item in range(1, int(math.sqrt(number)) + 1):
        if number % item != 0:
            continue
        factors.add(item)
        factors.add(number // item)
    factors.remove(number)
    aliquot = sum(factors)
    ...
```

### Points to call out

Students unfamiliar with `generator expressions` might write: `aliquot = sum([item for item in range(1, number) if number % item == 0])`.
Note this first creates a `list` of factors in memory by iterating over the entire range, then iterates once more over the `list` to `sum()` its values.
This is inefficient for both memory and processing time.
Dropping the `[]` drops `list` creation and allows `sum()` to lazily process a `generator expression`, which only requires a single iteration and a smaller memory footprint.
