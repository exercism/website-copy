# Mentoring

## Problem and challenges

The problem asks for two functions, `smallest` and `largest`, that will respectively give the smallest and the largest palindrome number that is a product of at least one pair of factors in a given range.

The main challenge of this problem is performance.
A naive **O(N²logN)** solution can lead to timeouts when running the tests online.

## Reasonable solution

```python
import operator
from typing import Callable, Optional, Sequence

Factors = list[list[int]]
Result = tuple[Optional[int], Factors]
Comparison = Callable[[int, int], bool]


def is_palindrome(num: int) -> bool:
    textual = str(num)
    return textual == textual[::-1]


def search(factor_range: Sequence[int],
           better_found: Comparison) -> Result:
    found = None
    factors: Factors = []
    for i in factor_range:
        for j in factor_range:
            num = i*j
            # note: further values of j will yield even worse num
            if found and not better_found(num, found):
                break
            if is_palindrome(num):
                if num == found:
                    factors.append([i, j])
                else:
                    factors = [[i, j]]
                found = num
    return (found, factors)


def largest(min_factor: int, max_factor: int) -> Result:
    if min_factor > max_factor:
        raise ValueError('min must be <= max')
    # decrementing for time optimization (see note above)
    return search(range(max_factor, min_factor - 1, -1),
                  operator.ge)


def smallest(min_factor: int, max_factor: int) -> Result:
    if min_factor > max_factor:
        raise ValueError('min must be <= max')
    return search(range(min_factor, max_factor + 1),
                  operator.le)
```

## Common suggestions

- Point out this observation for performance:
    - With the same `i`, a palindrome `i * j` gets larger for larger values of `j`
    - The opposite is also correct, the product gets smaller along with `j`
    - This allows breaking early from the inner loop
- Suggest avoiding code duplication between `largest` and `smallest`.
- Prefer informal wording for performance, such as *faster* or *slower*, since formal complexity analysis is not trivial for this problem.
- If the author asks for more, steer them towards the faster solution and the advanced complexity discussion below.

## Talking points

- Where can they trade-off between performance and readability?
- What is the time complexity of their solution?
- How can callables help avoid code duplication?
- (Faster solution) Where is the bottleneck?

## Faster solution

```python
from typing import Iterator, Optional

Factors = list[list[int]]
Result = tuple[Optional[int], Factors]


def palindromes(digits: int,
                reverse: bool = False,
                add_zero: bool = False) -> Iterator[int]:
    # Palindromes are:
    # - [digit]: 1, 2, ..., 9
    # - [digit][same_digit]: 11, 22, ..., 99
    # - [digit][palindrome][same_digit]: e.g. 4(56765)4
    if reverse:
        outer_range = range(9, -1 if add_zero else 0, -1)
    else:
        outer_range = range(0 if add_zero else 1, 10)
    for outer in outer_range:
        if digits == 1:
            yield outer
        elif digits == 2:
            yield outer * 11
        else:
            for inner in palindromes(digits-2,
                                     reverse=reverse,
                                     add_zero=True):
                number = outer*10**(digits-1) + inner*10 + outer
                yield number


def get_factors(number: int,
                min_factor: int,
                max_factor: int) -> Factors:
    factors: Factors = []
    # number = i*j
    # i in [1, sqrt(number)] when i <= j
    # i, j in [min_factor, max_factor]
    # i, j in [p//max_factor, p//min_factor]
    for i in range(max(min_factor, number//max_factor),
                   min(int(number**0.5), max_factor,
                       number//min_factor) + 1):
        if number % i == 0:
            j = number // i
            if j < i:
                break
            if j >= min_factor and j <= max_factor:
                factors.append([i, j])
    return factors


def search(min_factor: int,
           max_factor: int,
           reverse: bool = False) -> Result:
    min_p, max_p = (min_factor*min_factor, max_factor*max_factor)
    min_digits, max_digits = (len(str(min_p)), len(str(max_p)))
    if reverse:
        digits_range = range(max_digits, min_digits-1, -1)
    else:
        digits_range = range(min_digits, max_digits+1)
    for digits in digits_range:
        for p in palindromes(digits, reverse=reverse):
            if p >= min_p and p <= max_p:
                factors = get_factors(p, min_factor, max_factor)
                if factors:
                    return p, factors
    return None, []


def largest(min_factor: int, max_factor: int) -> Result:
    if min_factor > max_factor:
        raise ValueError('min must be <= max')
    return search(min_factor, max_factor, reverse=True)


def smallest(min_factor: int, max_factor: int) -> Result:
    if min_factor > max_factor:
        raise ValueError('min must be <= max')
    return search(min_factor, max_factor)
```

## Complexity discussion

- Time complexity of naive solution is **O(*N²logN*)**
    - ***N*** is the worst case size of the factor range, i.e., `max_factor`
    - ***N²*** is the size of the palindrome range
    - ***log10(N²)*** is digit count of palindromes, simplifies to **O(*logN*)**
- Time complexity of reasonable solution is slightly higher than **O(*NlogN*)**
    - ***f*** is the frequency of palindromes within integer domain
    - inner loop would take **O(*1/f*)** at first, approaching **O(*1*)** gradually
- Time complexity of faster solution is **O(*N<sup>3/2</sup>*)**
    - faster solution hops to the next palindrome with **O(*1*)**
    - ***sqrt(N)*** hops are needed around *N²*
    - factorization of *N²* takes  **O(*N*)**
    - prime lookups can make this solution even faster
    - for very large *N*, reasonable solution would perform better
- Profiling code:

```python
def profile(count):
    for _ in range(count):
        largest(min_factor=100, max_factor=9999)
        smallest(min_factor=100, max_factor=9999)
cProfile.run("profile(1000)", sort=1)
```

| Solution | Time complexity | Test runtime | Profile runtime | Function calls |
| :--- | :---: | :---: | :---: | :---: |
| Naive solution | N²logN | 11s | 10h | 200G |
| Reasonable solution | NlogN | 0.03s | 10s | 40M |
| Faster solution | N<sup>3/2</sup> | 0.03s | 0.4s | 700K |
