### Reasonable solutions

```python
def is_leap_year(year):
  return year % 4 == 0 and (year % 100 != 0 or year % 400 == 0)
```

### Common suggestions
- there are just two cases that return True:
  - a year is a multiple of 4 *and not** 100
  - a year is a multiple of 4, 100, and 400
- order of operations matter:
  - 75% of all years *cannot* be leap years because they are not mulitples of 4; test `year % 4 == 0` first
  - 98.97% of all years that are multiples of 4 are not multiples of 100; test `year % 100 != 0` second
  - 1.03% of all years that are multiples of 4 are also multiples of 100 and 400; test `year % 400 == 0` third
- order of evaluation matters:
  ```python
  year % 4 == 0 and year % 100 != 0 or year % 400 == 0
  ```
  _looks_ right, but will force a year like 999 to be checked for being a multiple of 400 unnecessarily
- eliminate duplicate work; no year should ever have to be checked multiple times for the same condition

### Talking points
- it's very helpful to internalize the rules Python uses for [expression order](https://docs.python.org/3/reference/expressions.html#evaluation-order)
- remember that **and** and **or** do not return **bool**, but instead:
  - **and** returns either the first term that is *considered* False, or the last term that is *considered* True
  - **or** returns either the first term that is *considered* True, or the last term that is *considered* False
