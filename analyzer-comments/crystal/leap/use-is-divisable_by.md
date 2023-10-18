# Modulo

Modulo comparisons is perfectly valid within Crystal, but a more readable way to compare the remainder of a division is with the [divisible_by?][divisible_by] method.
For example:

```crystal
# Rather than:
number % 2 == 0

# Consider:
number.divisible_by?(2)
```

[divisible_by]: https://crystal-lang.org/api/latest/Int.html#divisible_by%3F%28num%29%3ABool-instance-method
