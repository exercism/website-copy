### Reasonable solutions

This is a nice, concise, very efficient solution:

```cpp
namespace leap {
  bool is_leap_year(const int year)
  {
    return ((year % 4 == 0) && (year % 100 != 0)) ||
           (year % 400 == 0);
  }
}  // namespace leap
```

You can also use boolean XOR (which looks a little prettier) if you notice that the "divisible by 100" case, will never happen independently of the "divisible by 4" case.

```cpp
namespace leap {
  bool is_leap_year(const int year)
  {
    return (year % 4 == 0) ^
           (year % 100 == 0) ^
           (year % 400 == 0);
  }
}  // namespace leap
```

### Common suggestions

- There are just two cases that return `true`:
  - a year is a multiple of 4 *and not** 100
  - a year is a multiple of 4, 100, and 400
- Don't use `if`/`else` branching to return a `bool`. Just return a boolean expression.
- Don't try to rely on order of operations too much. Just use parentheses to make everything obvious.
- Make sure you enabled **all** tests.

### Talking points

- Argument name vs no argument name in declaration
- Meaningful argument names
- Using `unsigned` integer types
- `!(year % 4)` vs `year % 4 == 0`
- Consider making the function a `constexpr` function
