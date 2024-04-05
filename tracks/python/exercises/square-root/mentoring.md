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

## Talking points

The formula to revise estimates is small, the overall algorithm is pretty simple.

### The algorithm

The idea of the algorithm is to iteratively compute a better, revised estimate for the square root, using the previous estimate.

For example, a single iteration in calculating the square root of 50 looks like this:

```py
x_0 = 50 / 2                # 25, not a very good first guess
x_1 = (x_0 + 50 / x_0) / 2  # 13.5, not a very good revised estimate either
```

The power of Heron's method comes from how quickly it converges to a good approximation of a square root.
In just 5 iterations, we get an estimation accurate to 6 decimal places!

```py
x_0 = 50 / 2                    # 25
x_1 = (25 + 50/25) / 2          # 13.5
x_2 = (13.5 + 50/13.5) / 2      # 8.60
x_3 = (8.60 + 50/8.60) / 2      # 7.21
x_4 = (7.21 + 50/7.21) / 2      # 7.0724
x_5 = (7.0724 + 50/7.0724) / 2  # 7.0710679
...
x_n = sqrt(50) =~ 7.0710678118654755
```

People may possibly struggle with figuring out how many iterations to perform to get a decent estimate.
Technically, you could get away with hardcoding the iteration count to a number as small as 10 and that would get you good accuracy.
Good solutions, however, would use an "error margin" or "tolerance level" as a condition to a while loop, like shown above, to avoid performing more calculations than necessary.

### Alternative solutions

#### Binary Search

The problem could also be tackled using binary search.
Since the number line is sorted, we can use binary search to cut the search space in half with each iteration.

This is a fairly standard implementation of the binary search algorithm.

```py
def square_root(number):
    left, right = 0, number

    while left < right:
        mid = left + ((right - left) / 2)
        if mid * mid > number:
            right = mid
        elif mid * mid < number:
            left = mid + 1
        else:
            return int(mid)

    return int(left)
```
