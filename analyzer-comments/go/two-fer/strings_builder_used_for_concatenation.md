# strings builder used for concatenation

Using `strings.Builder` is overkill for this simple use case.
Use `fmt.Sprintf` or simple concatenation using the `+` operator, instead.
