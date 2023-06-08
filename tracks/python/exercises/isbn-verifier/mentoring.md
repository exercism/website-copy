# Mentoring

## Problem and Challenges

The problem asks you to write an ISBN validation checker.

* Any "-" in the input string should be ignored.
* A valid ISBN must be 10 values long.
* A valid ISBN must be entirely digits, other than the last character.
* A valid ISBN may have `"X"` as the last character, which should be treated as a `10` value.
* The ISBN is valid if the weighted sum of the digits is a multiple of 11 where the weight is the digit's value, ranging from 10 to 1.

## Reasonable Solution

```python
def is_valid(isbn: str) -> bool:
    values = [value for value in isbn if value != "-"]

    if len(values) != 10:
        return False

    if values[-1] == "X":
        values[-1] = "10"

    if any(not value.isdigit() for value in values):
        return False

    total = sum(int(value) * (10 - position) for position, value in enumerate(values))
    return total % 11 == 0
```

## Talking Points

### Generator expressions

The sum can be computed using the [built-in function `sum()`][builtin-sum] (see "Reasonable Solution") or with a `for` loop.

```python
total = 0
for position, value in enumerate(values)):
    total += int(value) * (10 - position)
```

Generator expressions are considered very Pythonic.
Generators were added to the language (see [PEP-255]) because they provide a compact, clean and efficient method for iterating through data (compared to other approaches such as building lists or iterators).

### The position value

The position values can be directly generated using `range()`.
However, using `range()` requires mapping the position value to an ISBN positional value, by computing an index or via `zip()`.

```python
total = 0
for position, value in zip(range(10, 0, -1), values):
    total += int(value) * position
```

The [built-in function `enumerate()`][builtin-enumerate] provides a nice way to get both a position and a value.
The position returned by `enumerate()` does need to be modified (`10 - position`) to be used.

### The trailing "X" value

The final value can be handled in the summation loop by checking the position and the value and replacing "X" with 10.
Doing so allows for keeping the ISBN as a `str` instead of converting it to `list[str]` to be able to hold a `"10"` value.

```python
total = 0
for position, value in enumerate(isbn):
    if position == 9 and value == "X":
        total += 10
    else:
        total += int(value) * (10 - position)
```

Recognize that changing the data from `str` to `list[str]` allows for more flexibility of what can be stored (`"10"`) and a simpler summation loop.

### Checking for non-digits

The [built-in function `any()`][builtin-any] is a concise approach for checking for any non-digit values in the input.
If the input is first converted to a string and a trailing "X" is replaced with a digit, the digit check is fairly straight forward.
If the trailing "X" is not handled prior to the digit check, the final character needs to be handled separately.

```python
if any(not value.isdigit() for value in isbn[:-1]):
    return False
if not (isbn[-1].isdigit() or isbn[-1] == "X"):
    return False
```

Creating a list of values which can store `"10"` in place of `"X"` simplifies the digit check.

Another approach to checking for non-digits is to wrap the `int()` call in a `try-except`.
This allows leaving the input as a `str` if the last value is handled separately to support an `"X"` value.

```python
total = 0
for position, value in enumerate(isbn):
    if position == 9 and value == "X":
        total += 10
    else:
        try:
            total += int(value) * (10 - position)
        except ValueError:
            return False
```

Checking for non-digits separately from the summation allows for explicitly and directly handling that test.
Checking explicitly for a condition makes the test more clear and separates various pieces of logic.

[builtin-any]: https://docs.python.org/3/library/functions.html#any
[builtin-enumerate]: https://docs.python.org/3/library/functions.html#enumerate
[builtin-sum]: https://docs.python.org/3/library/functions.html#sum
[PEP-255]: https://www.python.org/dev/peps/pep-0255/
