# Mentoring

## Problem and Challenges

The problem asks us to find the square roots of numbers without using builtin functions or operators, like `**`, `pow`, `math.pow`, `math.sqrt` or `sum`.

We should use a method from the wiki articles linked, like Heron's method.

## Reasonable Solutions

```python
def square_root(number):
    guess = number / 2
    revised = (guess + number / guess) / 2

    tolerance = 0.001
    while abs(revised - guess) > tolerance:
        guess = revised
        revised = (guess + number / guess) / 2

    return int(revised) # our answer should be an integer
```

### Talking points

The formula to revise estimates is small, the overall algorithm is pretty simple.

People may possibly struggle with figuring out how many iterations to perform to get a decent estimate. Technically, you could get away with hardcoding the iteration count to a number as small as 10 and that would get you good accuracy.

Good solutions, however, would use an "error margin" or "tolerance level" as a condition to a while loop, like shown above, to avoid performing more calculations than necessary.
