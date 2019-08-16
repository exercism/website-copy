Improve the efficiency by converting the string to a slice of `rune`s like this:

```go
ar := []rune(a)
```

The type in Go to hold a single character is `rune`. Splitting the string into a slice of single character strings and working with them is a lot slower than ...
Splitting the string into a slice of single character strings and working with them is a lot slower.
