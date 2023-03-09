# Mentoring
Consider guiding towards a solution in which none of the existing Python library functions are used, but rather one in which students create the logic/algorithm themselves.

## Problem and challenges

## Reasonable solution

This solution would be more expected of new Pythonista's, be that new to programming or coming from a different
language. Also, this is solution is encouraged so that the students come up with their own logic on how to tackle
this without the use of a library.

// TODO

## Compact solution

One of the easier ways for this exercise to be resolved is utilizing the `math` library's `sqrt()` method. However, this will only be valid for usage with a number greater than or equal to 0.

```python
def square_root(number: int) -> float:
  return math.sqrt(number)
```

## Talking points

### Exploration
Perhaps we can guide the learner towards exploring other solutions and the differences between them. Where should or could they look for more information about a library. If they submitted a solution without using `math.sqrt()`, show themthe compact solution and it's constraints.
