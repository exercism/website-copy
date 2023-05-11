# Mentoring

## Problem and challenges

The problem requires the student to sum each digit of an integer or _natural number_ raised to the number of digits' power.

## Reasonable solutions

This exercise can be solved in a fairly straightforward fashion:

```python
def is_armstrong(number):
    str_num = str(number)
    digits = (int(d) for d in str_num)
    count = len(str_num)
    total = sum(digit ** count for digit in digits)
    return number == total
```

This solution can also be written without the generator.
This avoids the more complex generator type at the expense of a more complex sum line.

```python
def is_armstrong(number):
    str_num = str(number)
    count = len(str_num)
    total = sum(int(digit) ** count for digit in str_num)
    return number == total
```

### Common Suggestions

#### Generator Expressions

```python
    # With an intermediate list passed to sum.
    total = sum([digit ** count for digit in digits])
    
    # With a generator expression passed to sum
    total = sum(digit ** count for digit in digits)

Students are often unaware of [generator expressions][pep-289] and that they can be passed directly to functions that accept iterables.
The first line uses a comprehension to build a `list`  for `sum()` to iterate through.
The middle step of a temporary list takes up space in memory and is not needed.
The second line shows the `list` replaced by an equivalent `generator expression` that `sum()` can also iterate through. 

Potential feedback snippet:

```
`[f(a) for a in b]` iterates through `b` to create a list. You are then passing this list to a function which iterates through that list to build a result and discards that list. You can avoid that extra middle step of building and storing a list by passing a generator to the function instead and having the function process the elements of that iterator directly! You can do this either by doing `func(f(a) for a in b)` or `generator = (f(a) for a in b); func(generator)`
```

### Talking points

Students unfamiliar with `sum()` may use a for loop to add the values themselves:

```python
def is_armstrong(number):
    count = len(str(number))
    total = 0
    for digit in str(number):
        total += int(digit) ** count
    return number == total
```

Suggest having a look at Python's [built-in functions][functions] for a helper function that can make this easier.

[functions]: https://docs.python.org/3/library/functions.html
[pep-289]: https://www.python.org/dev/peps/pep-0289/
