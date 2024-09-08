# Mentoring

## Problem and challenges

The problem describes a scenario played out on a chessboard.
One grain is placed on the first square.
Twice that number of grains is placed on the next square.
The doubling continues until all squares are filled.

The problem requires writing a `square(number)` function which returns the number of grains on any given square.

The problem requires writing a `total()` function which returns the total number of grains on the board.

## Reasonable solutions

```python
def square(number):
    """Return the number of grains on a given square number.
    
    :param number: int - square number on which we want to calculate the amount of grains.
    :return: int - the amount of grains present on the given square number(number).
    """
    if number < 1 or number > 64:
        raise ValueError("square must be between 1 and 64")
    else:
        return 2**(number - 1)


def total():
    """Return the total number of grains on the chess board.
    
    :return: int - total number of grains a chess board can contain.
    """
    # Note: 2^0 + 2^1 + 2^2 + 2^3 +....+ 2^n = (2^(n + 1)) - 1.
    return 2**64 - 1
```

### `square(number)`

As we did `2**(number - 1)` on block one there will be only 1 grain, 2 to the power of 0 equals 1.
On block 2 there will be 2 and on block 3 there will be 4 which is equal to 2 to the power of 1, and 2 to the power of 2, respectively.
Hence generalized, **2 to the power of (number-1)**.

### `total()`

There is a general formula : **2^0 + 2^1 + 2^2 + 2^3 +....+ 2^n = (2^(n + 1)) - 1**.

## Bitwise left shift operator

With decimal values, multiplying a value by the base (10) shifts the value over one place.
Conversely, shifting left is the same as multiplying by the base.
The same holds true for binary numbers; shifting left by one position is the same as multiplying by the base (2).
There is a bitwise left shift operator, `<<`.
`number << places` shifts the binary `number` left `places` positions.

Shifting multiple positions is the same as multiplying by the base multiple times.
Multiplying a `number` by `base`, `power` times is an exponent, that is, `number * base**power`.
Therefore, `number * base**power` is the same as shifting `number` left `power` times.
For example, `3 * 10**4` is the same as shifting `3` to the left `4` times: `30000`.
Similarly for binary numbers, `number * base**power` is the same as shifting `number` left `power` ... where the `base` is 2.
Therefore `3 * 2**power` is the same as `3 << power`.

The bitwise shift operator is a single instruction on many CPUs, which makes it fast.
Exponents are typically not a CPU instruction and instead often require a loop.
Therefore replacing `2**power` with `1 << power` is usually faster.

Note: while bitwise shift operators are faster, they can make the code harder to understand.
While this does improve code efficiency, the difference is rarely significant.

```
>>> for i in range(5):
...     print(f"{2 ** i} == {1 << i} == {bin(2 ** i)}")
...
1 == 1 == 0b1
2 == 2 == 0b10
4 == 4 == 0b100
8 == 8 == 0b1000
16 == 16 == 0b10000
```

We can replace instances of `2**n` with bitwise left shift operators:

```python
def square(number):
    if number < 1 or number > 64:
        raise ValueError("square must be between 1 and 64")
    else:
        return 1 << number - 1 
        

def total():
    # Note: 2^0 + 2^1 + 2^2 + 2^3 +....+ 2^n = (2^(n + 1)) - 1
    return (1 << 64) - 1
```
