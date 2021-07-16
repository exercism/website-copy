# Mentoring

## Problem and Challenges

The problem asks you to create a `Robot` that has a unique name.
The name must be unique across all Robots which requires a global variable
or class variable to track names.
The name must be randomly generated, containing two uppercase letters
followed by three digits.

## Reasonable Solution

```python
import random
import string

class Robot(object):

    # Class attribute used to track all names.
    names = set()

    def __init__(self):
        while True:
            self.name = ''.join(
                random.choices(string.ascii_uppercase, 2) + random.choices(string.digits, 3)
            )
            if self.name not in Robot.names:
                Robot.names.add(self.name)
                break

    def reset(self):
        self.__init__()
````

## Talking Points

### Generating random sequences

`string.ascii_uppercase` is the simplest way to get the list of uppercase ASCII
letters. Solutions that make use of `ord()` and `chr()` are thinking too low
level.

`random.sample()` is not suitable for selecting multiple values since it does
not use "replacements", i.e. `random.sample(ascii_uppercase)` will never return
`["A", "A"]`.

`[random.choice(ascii_uppercase) for _ in range(2)]` can be replaced using
`random.choices(ascii_uppercase, k=2)`

`random.randint(100, 999)` is a simple way to force a 3 digit number, but it
excludes 10% of the sample space. `random.choices(string.digits, k=3)` can be
used, or formatting, like `f"{random.randint(0, 999):03}"`

### Ensuring the name is unique

Both a module level global and a class level attribute works for this.
`list` is the "simpler" data type here but a `set` is more efficient for this,
as (1) we will do a lot of membership checking, (2) duplicates cannot occur,
and (3) order is not important.

One approach sometimes used to handle unique names is recursion when a name
is already in use. Recursion is quite expensive compared to a `while` loop
and unnecessary. When a lot of names are in use, the stack can fill up quickly
and the max recursion depth can be hit. Simply looping until a good name is
can be found is much better.
