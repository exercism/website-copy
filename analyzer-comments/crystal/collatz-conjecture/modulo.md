# Modulo

Modulo comparisons is perfectly valid within Crystal, but a more readable way to compare the remainder of a division is with the [`divisible_by?`][divisible_by] method.
Or even better if you want to check if a number is odd or even, use the [`odd?`][odd?] and [`even?`][even?] methods.

For example:

```crystal
# Rather than:
number %% 2 == 0

# Consider:
number.even?
```

[divisible_by]: https://crystal-lang.org/api/latest/Int.html#divisible_by%%3F%%28num%%29%%3ABool-instance-method
[odd?]: https://crystal-lang.org/api/Int.html#odd%%3F%%3ABool-instance-method
[even]: https://crystal-lang.org/api/Int.html#odd%%3F%%3ABool-instance-method
