The type in Go to hold a single character is `rune`. A string can be transformed into a `[]rune` (slice of runes) via type conversion: `var aRunes = []rune(a)`.
Splitting the string into a slice of single character strings and working with them is a lot slower.
