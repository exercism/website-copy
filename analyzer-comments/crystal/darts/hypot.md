# Pow

Using `pow`, `sqrt` or `**` is totally valid and can be necessary in many situations.
However when we want a distance in Cartesian space we can use the [`hypot` method][hypot] which returns the hypotenuse of a right angle triangle with sides x and y.

```crystal
# Rather than:
Math.sqrt(number ** 2 + another_number ** 2)

# Consider:
Math.hypot(number, another_number)
```

[hypot]: https://crystal-lang.org/api/Math.html#hypot%28value1%2Cvalue2%29-instance-method