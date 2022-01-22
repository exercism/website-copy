# Mentoring

## Problem and Challenges

The problem asks you to classify one list relative to another.

## Reasonable Solution

```python
def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL

    for i in range(len(list_two) - len(list_one) + 1):
        if list_one == list_two[i:i + len(list_one)]:
            return SUBLIST

    for i in range(len(list_one) - len(list_two) + 1):
        if list_two == list_one[i:i + len(list_two)]:
            return SUPERLIST

    return UNEQUAL
```

Or with less code duplication but additional complexity:

```
def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL

    r = SUBLIST
    if len(list_one) > len(list_two):
        list_one, list_two = list_two, list_one
        r = SUPERLIST

    for i in range(len(list_two) - len(list_one) + 1):
        if list_one == list_two[i:i + len(list_one)]:
            return r

    return UNEQUAL
```

## Talking Points

### Slice checks

Some students might misunderstand the problem and assume this can be solved using sets and set operations.
Pointing out the differences between lists and sets is helpful here.
Sets cannot have duplicate elements and do not have ordering.

Some students may be tempted to solve this by converting the inputs to a string and checking for substrings.
The tests explicitly attempt to make that fail but clever string building can work around the tests.
Point out, however the string is formed, there is most likely a way to form a list element in one list which matches the string formed by the other list.

The only correct approach to this exercise is to compare sublists.

### Minimizing checks

Forced with comparing sublists, it is tempting to "brute force" this solution and generate more sublists than is required.
For an efficient solution, it is important to recognize that a list of size `m` can only fit in a list of size `n` in `n - m + 1` ways.
Ask the student to think how many ways a list of unknowns `[a, b, c]` can fit into the list `[1, 2, 3, 4]`.
Knowing the valid bounds minimizes the checks needed and avoids checking invalid slices, i.e. `[list_one[i:len(list_two)] for i in range(len(list_one))]`.

Checking the list lengths prior to the `for` loop is not necessary, as `range(0)` or `range(-1)` returns an iterable which outputs zero elements.

Any additional checks (e.g. checking for empty lists) is not necessary and simply increases code complexity.
