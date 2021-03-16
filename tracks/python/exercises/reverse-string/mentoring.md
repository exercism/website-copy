# Mentoring

### Problem and challenges

The problem requires the student to reverse a given string.

### Reasonable solutions

[Extended Slice Notation][1] is the fastest way to reverse a string in Python.

```python
def reverse(text):
    return text[::-1]
```

Though it can be tricky for beginners to comprehend and some developers
consider it less readable, so

```python
def reverse(text):
    return "".join(reversed(text))
```

... is also a reasonable straightforward solution with an acceptable
performance.

### Unreasonable solutions

```python
def reverse(text):
    i = len(text) - 1
    new_word = ''
    while i > -1:
        new_word = new_word + text[i]
        i = i - 1
    return new_word
```

- Manual string concatenation is slow and should generally be avoided.
- The student can start by replacing `while` with `for` and `range` for better
  readability and error tolerance.
- Lack of knowledge about negative indexes.

```python
def reverse(text):
    reversed_list = list(text)
    reversed_list.reverse()
    reversed = ''
    for character in reversed_list:
        reversed += character
    return reversed
```

- Manual string concatenation again.
- The student can replace `for` loop with a single `join` call.
- Single built-in `reversed` call is a better alternative to `list` and
  `.reverse()` calls.
- Shadowing built-in object names (`reversed`) with custom ones is error
  prone.

### Common suggestions

- Make sure students didn't build the result string with character by character
  concatenation - it is quite slow.
- Students with experience in other languages tend to use positive indexes
  where negative ones may be more readable and pythonic.
- One can omit different parts of a slice notation, e.g.
  `text[len(text)-1::-1]` is needlessly explicit.
- Do not convert initial string to list or other collection, `reversed`
  accepts strings.

### Talking points

- Python support for negative indexes.
- Slicing notation - `[start:stop:step]`.
- Solution performance - slicing vs. manual concatenation vs. `join` call.

 [1]: https://docs.python.org/3.8/whatsnew/2.3.html#extended-slices
