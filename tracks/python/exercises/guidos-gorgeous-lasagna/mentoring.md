# Mentoring

## Problem statement

The problem has four tasks.

1. Define a constant, `EXPECTED_BAKE_TIME`, which represents the total bake time.
1. Define a function `bake_time_remaining()` which takes the elapsed bake time and returns the remaining bake time.
1. Define a function `preparation_time_in_minutes()` which takes the number of layers in the lasagna and returns how long it takes to prepare the lasagna.
1. Define a function `elapsed_time_in_minutes()` which takes the number of layers in the lasagna and the elapsed bake time.
  This function then returns how much time has elapsed between preparing the lasagna and the elapsed bake time.

## Reasonable solution

This is the exemplar solution (as of 2025/06/02).

```python
"""Functions used in preparing Guido's gorgeous lasagna.

Learn about Guido, the creator of the Python language: https://en.wikipedia.org/wiki/Guido_van_Rossum
"""

# time the lasagna should be in the oven according to the cookbook.
EXPECTED_BAKE_TIME = 40
PREPARATION_TIME = 2


def bake_time_remaining(elapsed_bake_time):
    """Calculate the bake time remaining.

    :param elapsed_bake_time: int - baking time already elapsed.
    :return: int - remaining bake time (in minutes) derived from 'EXPECTED_BAKE_TIME'.

    Function that takes the actual minutes the lasagna has been in the oven as
    an argument and returns how many minutes the lasagna still needs to bake
    based on the `EXPECTED_BAKE_TIME`.
    """

    return EXPECTED_BAKE_TIME - elapsed_bake_time


def preparation_time_in_minutes(number_of_layers):
    """Calculate the preparation time.

    :param number_of_layers: int - the number of lasagna layers made.
    :return: int - amount of prep time (in minutes), based on 2 minutes per layer added.

    This function takes an integer representing the number of layers added to the dish,
    calculating preparation time using a time of 2 minutes per layer added.
    """

    return number_of_layers * PREPARATION_TIME


def elapsed_time_in_minutes(number_of_layers, elapsed_bake_time):
    """Calculate the elapsed time.

    :param number_of_layers: int - the number of layers in the lasagna.
    :param elapsed_bake_time: int - elapsed cooking time.
    :return: int - total time elapsed (in in minutes) preparing and cooking.

    This function takes two integers representing the number of lasagna layers and the
    time already spent baking and calculates the total elapsed minutes spent cooking the
    lasagna.
    """

    return preparation_time_in_minutes(number_of_layers) + elapsed_bake_time
```

### Magic Numbers

[Magic numbers][magic numbers], or unnamed numerical constants, are generally discouraged.
The Wikipedia article lists the pros and cons of magic numbers.
In this exercise, there are two numbers that come up: 40 and 2.
Those values should only be used to set constants; after that, the constants should be used.

The tests ensure the student is using a module constant for the `EXPECTED_BAKE_TIME`.
If the student does not use a module constant for the `PREPARATION_TIME`, suggest they do so.

Sample feedback:

```
The `preparation_time_in_minutes()` function contains 40, a [magic number](https://en.wikipedia.org/wiki/Magic_number_(programming)).
Can you instead use a module constant for that number, similar to `EXPECTED_BAKE_TIME`?
```

### Module constant naming convention

The convention in Python is to use `ALL_CAPS` when naming module constants.
The tests ensure the code contains one module constant, `EXPECTED_BAKE_TIME`.
If the student is using a module constant to store how long each layer takes to prepare, it should also be `ALL_CAPS`.
The stub suggests using `PREPARATION_TIME` for the constant name.

If the student is using a module constant which is not `ALL_CAPS`, you can suggest the following.

```
The convention in Python is to use `ALL_CAPS` for module constants.
Could you rename the preparation variable to follow those conventions?
```

### Code reuse

["Don't repeat yourself" (DRY)][dry] is a common software development principle.
Repeated code increases the burden of maintaining software, requiring code be synced across multiple locations.
Unsynced code often represents a software bug.
Putting code in a common function and reusing code by making function calls is a common strategy to reduce code duplication.

The function `elapsed_time_in_minutes()` needs to compute the preparation time.
Rather than repeating the calculation inside this function, this function should instead call `preparation_time_in_minutes()`.

If the student does not reuse `preparation_time_in_minutes()` inside `elapsed_time_in_minutes()`, you can suggest the following.

```
It is good practice when coding to [avoid repeating yourself](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself).
In `elapsed_time_in_minutes()` can you reuse a previously defined function to avoid repeating calculations?
```

[magic numbers]: https://en.wikipedia.org/wiki/Magic_number_(programming)
[dry]: https://en.wikipedia.org/wiki/Don%27t_repeat_yourself
