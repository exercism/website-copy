# Mentoring

## Problem and Challenges

The problem asks you to classify triangle types, encoded as a list of three side lengths.

## Reasonable Solution

```python
def is_valid(sides):
    if not sides[0]:
        return False
    return all(side * 2 < sum(sides) for side in sides)


def equilateral(sides):
    return is_valid(sides) and len(set(sides)) == 1


def isosceles(sides):
    return is_valid(sides) and len(set(sides)) < 3


def scalene(sides):
    return is_valid(sides) and len(set(sides)) == 3
```

Note: This exercise appears fairly early in the concept tree so students may not yet be familiar with generators.

## Talking Points

### Sets and unique values

This exercise could be solved by explicitly comparing various sides against each other.
For example, `equilateral` could be solved using `all(side == sides[0] for side in sides)`.
However, `len(set())` provides a quick way to count unique values in an iterable.
Recognizing that counting the number of _unique_ side lengths can be used to solve this simplifies the problem greatly.
Using sets also solves the need to handle different ways of combining various sides.

### Validation

Given that all three functions require validation, having a separate function for validation avoids code duplication.

Side validation can be done by computing all the side combinations and checking `one_side < sum(other_sides)`.
However, that requires computing different combinations of sides.
Instead, given the condition `one_side < sum(other_sides)`, add `one_side` to both sides of the comparison.
This gives `one_side + one_side < sum(other_sides) + one_side` or `2 * one_side < sum(sides)`.
Alternatively, `all(side < sum(sides) - side for side in sides)`.

### Decorators

Validation can be taken one step further in the form of a `decorator`, if the student is comfortable with `decorators`:

```python
# Decorator function.
def is_valid(func):

    def wrapped(sides):
        if not sides[0]:
            return False
        if not all(side * 2 < sum(sides) for side in sides):
            return False
        return func(sides)

    return wrapped


# Decorator in use.
@is_valid
def equilateral(sides):
    return len(set(sides)) == 1
```
