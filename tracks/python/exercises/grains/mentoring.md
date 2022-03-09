## Reasonable solution By calculating power.

```python
def square(number):
    """
    This Function must return the number of grains on a given square number.
    :parama: int square number on which we want to calculate the amount of grains.
    :return int amount of grains present on the give square number(number).
    """
    if(number<1 or number>64):
        raise ValueError("square must be between 1 and 64")
    else:
        return 2**(number-1)


def total():
    """
    This Function must return the total number of grains on the chess board.
    :return int total number of grains a chess board can contain.
    """
    #as 2^0+2^1+2^2+2^3+....2^n=(2^(n+1))-1
    return 2**(64)-1
```

### For function square(number):
as we did `2**(number -`1)` on block one there will be only 1 grain, 2 to the power of 0 equals 1.
on block 2 there will 2 and on block 3 there will be 4 which is equal to 2 to the power of 1, and 2 to the power of 2, respectively.
Hence generalized, **2 power (number-1)**.

### For function total():
there is a general formula:
**2^0+2^1+2^2+2^3+....+2^n=(2^(n+1))-1**.

## Solution using Bitwise left operator
```python
def square(number):
    if(number<1 or number>64):
        raise ValueError("square must be between 1 and 64")
    else:
        return 2<<(number-1)


def total():
    #as 2^0+2^1+2^2+2^3+....2^n=(2^(n+1))-1
    return 2<<(64)-1
```
### Left shift bitwise operator

**2 power n = 1 << n** 
```python
>>> 2^0
1
>>> 1 << 0  # 1 <<1   in binary -> 1
1
>>> 2^1
2
>>> 1 << 1 # 1 << 1  in binary -> 1 0
2
>>> 2^2
4
>>> 1 << 2 # 1 << 1  in binary -> 1 0 0
4
```
