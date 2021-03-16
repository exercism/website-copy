# Mentoring

## Reasonable solutions

This solution deliberately shows the two steps separately:
1) finding the set of numbers that are multiples and,
2) doing the summation of those numbers.

```python
def sum_of_multiples(limit, multiples):

    def is_multiple(number):
        for multiple in multiples:
            if number % multiple == 0:
                return True
        return False

    numbers = filter(is_multiple, range(limit))

    return sum(numbers)
```

The solution below shows a more terse approach:

```python
def sum_of_multiples(limit, multiples):
    return sum(num for num in range(limit)
               if any((num % x == 0 for x in multiples)))
```

When limit is very large and values in multiples are high in the range, there could be a lot of computational time wasted on unnecessary division, so a collection-based approach may be more suitable:

```python
def sum_of_multiples(limit, multiples):
    return sum({n for m in multiples for n in range(m, limit, m)})
```

## Common Suggestions
 - It's tempting to write a complex one liner for this, but that should be discouraged in favour of
   PEP8 compliant solutions for readability and maintainability.


## Talking points
 - It's possible to do this with a set or list [and associated comprehensions] instead of the generators shown above. 
   The benefit of a generator is the space used is constant no matter how large the inputs are.
