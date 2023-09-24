# string concatenation

String concatenation is perfectly valid within Ruby, but a more common way to compose a string is with [string interpolation][interpolation]. For example:

```crystal
# Rather than:
"One for " + name_variable + ", one for me"

# Consider:
"One for #{name_variable}, one for me."
```

[interpolation]: https://crystal-lang.org/reference/latest/syntax_and_semantics/literals/string.html#interpolation
