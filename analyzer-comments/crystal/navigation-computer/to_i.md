# to_i{bit}

Using the `to_i{bit}` method, is a valid way to convert a value to a certain base.
But when defining a [number literal][int], it is more idiomatic to use the `_i{bit}` suffix.

```crystal
# Rather than:
500034214414.to_i64

# Consider:
500034214414_i64
```

[int]: https://crystal-lang.org/reference/latest/syntax_and_semantics/literals/integers.html