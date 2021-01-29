Use the built-in type `rune` to work with individual characters in Go.
A `string` can be converted into a `[]rune` (slice of runes) with:

```go
aRunes := []rune(a)
```

Splitting the string into a lot of small strings (one for each rune) works, but is inefficient.
