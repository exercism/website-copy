# Mentoring

## Problem and Challenges

The problem asks you to write a function which returns earned points in a single toss of a Darts game.
The dart's location is given as a Cartesian point (an `x` and `y` value).
Points are based on the distance from the center.

## Reasonable Solution

```python
import math


def score(x, y):
    distance = math.sqrt(x * x + y * y)
    if distance <= 1:
        return 10
    if distance <= 5:
        return 5
    if distance <= 10:
        return 1
    return 0
```

## Talking Points

### Avoiding the use of `elif`

It can be tempting to use `elif` for the conditionals after the first one.
However, doing so would be an "unnecessary elif after return", as flagged by Pylint ([R1705][R1705]).

### Minimizing the number of comparisons

The distance checks can compute the upper and lower bound for each point band.
However, the extra comparions are not needed as they are covered by the prior conditions.

```python
if 0 <= distance <= 1:
    return 10
if 1 < distance <= 5:
    return 5
if 5 < distance <= 10:
    return 1
```

### Reducing imports

The `math` import is not strictly needed.
An alternative is to compute `distance = x * x + y * y` and use squared values for the point bands: 1, 25, 100.

```python
def score(x, y):
    distance = x * x + y * y
    if distance <= 1:
        return 10
    if distance <= 25:
        return 5
    if distance <= 100:
        return 1
    return 0
```

Alternatively, the square root can be computed using `value ** 0.5`.

### Using a loop

The distance checks all have a very similar form: `if distance <= value: return points`.
Rather than repeating this code three times, a loop can be used.

```python
import math


BANDS = [(1, 10), (5, 5), (10, 1)]


def score(x, y):
    distance = math.sqrt(x * x + y * y)
    for band, points in BANDS:
        if distance <= band:
            return points
    return 0
```

The zero-point case can also be added to the loop using `(math.inf, 0)` or `(float("int"), 0)`.
However, analysis tools (`pylint`, `mypy`) will complain about the apparent missing return statement if no conditions are met.
The missing return statement could be worked around by raising a `RuntimeError` after the loop.

The `BANDS` can also be set to a `dict` since `dict` is ordered since Python 3.7.

[R1705]: https://pylint.pycqa.org/en/latest/messages/refactor/no-else-return.html
