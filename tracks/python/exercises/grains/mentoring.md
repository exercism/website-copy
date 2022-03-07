## Reasonable solution By calculating power.

```
def square(number):
    """
    This Function is going to return the number of grains on a given square number.
    :parama: int square number on which we want to calculate the amount of grains.
    :return int amount of grains present on the give square number(number).
    """
    if(number<1 or number>64):
        raise ValueError("square must be between 1 and 64")
    else:
        return 2**(number-1)


def total():
    """
    This Function is going to return the total number of grains on the chess board.
    :return int total number of grains a chess board can contain.
    """
    #as 2^0+2^1+2^2+2^3+....2^n=(2^(n+1))-1
    return 2**(64)-1
```

### For function square(number):
as we did 2**(number-1) on block one there will be only 1 grain, 2 power 0 = 1.
on block 2 there will 2 and on block 3 there will be 4 which is equal to 2 power 1 and 2 power 2 respectively.
Hence gerenalized **2 power (number-1)**.

### For function total():
there is a gerenal formula:
**2^0+2^1+2^2+2^3+....+2^n=(2^(n+1))-1**.

## Solution using Bitwise left operator
```
def square(number):
    if(number<1 or number>64):
        raise ValueError("square must be between 1 and 64")
    else:
        return 2<<(number-1)


def total():
    #as 2^0+2^1+2^2+2^3+....2^n=(2^(n+1))-1
    return 2<<(64)-1
```
Left shift bitwise operator

1<<0 --> int binary 0 0 1 --> decimal 1 =2^0

1<<1 --> int binary 0 1 0 --> decimal 2 =2^1

1<<2 --> int binary 1 0 0 --> decimal 4 =2^2

1<<n --> =2^n
