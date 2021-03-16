# Mentoring

### Reasonable solutions

An iterative solution is fine:

```python
def binary_search(list_of_numbers, number):
    low = 0
    high = len(list_of_numbers)
    while low < high:
        mid = (low + high) // 2
        mid_value = list_of_numbers[mid]
        if number < mid_value:
            high = mid
        elif number == mid_value:
            return mid
        else:
            low = mid + 1
    raise ValueError('number not found')
```

And so is a recursive solution:

```python
def binary_search(list_of_numbers, number):
    return binary_search_helper(list_of_numbers, number, 0,
                                len(list_of_numbers))


def binary_search_helper(list_of_numbers, number, low, high):
    if low >= high:
        raise ValueError('number not found')
    else:
        mid = (low + high) // 2
        mid_value = list_of_numbers[mid]
        if number < mid_value:
            return binary_search_helper(list_of_numbers, number, low, mid)
        if number == mid_value:
            return mid
        return binary_search_helper(list_of_numbers, number, mid + 1, high)
```

### Unreasonable Solutions

The whole point of binary search is to efficiently find a value in the list, in
O(log(n)) time.  Any solution that searches the entire list, or copies even
half the list is missing the point.  This recursive solution gets the logic
right, but copies the remaining list on each recursive call, so it runs in O(n) time:

```python
def binary_search(list_of_numbers, number):
    count = len(list_of_numbers)
    if count == 0:
        raise ValueError('number not found')
    else:
        mid = count // 2
        mid_value = list_of_numbers[mid]
        if number < mid_value:
            return binary_search(list_of_numbers[:mid], number)
        if number == mid_value:
            return mid
        return (mid + 1) + binary_search(list_of_numbers[mid+1:], number)
```

### Common suggestions
- When the code gets the wrong answer, find a small test case that fails and suggest thinking through the logic to see where it goes wrong.

### Talking points
- Using a single variable to track where the midpoint is on each iteration is not enough, because you also need to track how long the current sub-list is.
- You can represent the high end of the range as the last index where the value could be (inclusive), or one past that (exclusive).  The exclusive approach seems more natural in Python, because that's the way slicing works.
- There's a builtin binary seach functionality in python called bisect:

```python
import bisect


def binary_search(list_of_numbers, number):
    idx = bisect.bisect_left(list_of_numbers, number)
    if idx != len(list_of_numbers) and list_of_numbers[idx] == number:
	     return idx
    raise ValueError("number not found")
```

