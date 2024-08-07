# Pow

Using the `pow`, `sqrt` or `**` is totally valid and can be neassisary in many situations.
However when wanting a distance in 2d space we can use the [`hypot` method][hypot] which returns the hypotenuse of the x and y lengths.

```crystal
# Rather than:
Math.sqrt(number ** 2 + another_number ** 2)

# Consider:
Math.hypot(number, another_number)
```

[hypot]: https://crystal-lang.org/api/Math.html#hypot%28value1%2Cvalue2%29-instance-method