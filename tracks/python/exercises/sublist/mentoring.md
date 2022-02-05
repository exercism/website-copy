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

```python
def sublist(list_one, list_two):
    if list_one == list_two:
        return EQUAL

    result = SUBLIST
   
    if len(list_one) > len(list_two):
        list_one, list_two = list_two, list_one
        result = SUPERLIST

    for i in range(len(list_two) - len(list_one) + 1):
        if list_one == list_two[i:i + len(list_one)]:
            return result

    return UNEQUAL
```

## Talking Points

### Slice checks

Some students might misunderstand the problem and assume this can be solved using `sets` and/or `set operations`.
Pointing out the differences between `lists` and `sets` is helpful here - for example, `sets` cannot have duplicate elements and are not ordered.

Some students may be tempted to solve this exercise by converting the inputs to a `string` and checking for `substrings`.
The tests explicitly attempt to make that strategy fail, but clever `string` building can work around those tests.
Point out that however the string is formed, there is more than likely a way to craft a `list` element in one `list` which matches the `string` formed by the _other_ `list`.

The only correct approach to this exercise is to compare `sublists`.

### Minimizing checks

Forced into comparing `sublists`, there is a temptation to "brute force" this solution and generate more `sublists` than required.
For an _efficient_ solution, it is important to recognize that a `list` of size `m` can only fit in a `list` of size `n` in `n - m + 1` ways.
Ask the student to think through how many ways a `list` of unknown elements `[element_a, element_b, element_c]` can fit into the `list` `[element_1, element_2, element_3, element_4]`.
Knowing the valid bounds of the problem minimizes the checks needed and avoids checking invalid `slices/sublists` - for example, `[list_one[i:len(list_two)] for i in range(len(list_one))]`.

Checking the list lengths prior to the `for` loop is not necessary, as `range(0)` or `range(-1)` returns an `iterable` which produces zero elements.

Any additional checks (_for example, checking for empty lists_) is not necessary and simply increases code complexity.
