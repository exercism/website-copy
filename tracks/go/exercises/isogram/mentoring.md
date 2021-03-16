# Isogram

This exercise further reinforces concepts introduced in previous exercises regarding differences between `rune` and `string`.  
Students are encouraged to find ways to keep track of unique characters found in the input.

As always, _Unformatted or unlinted code is a reason not to approve._

## Reasonable solutions

```
package isogram

import "unicode"

// IsIsogram returns true if a word is an isogram
func IsIsogram(word string) bool {
	repeated := map[rune]bool{}
	for _, v := range word {
		if v == '-' || v == ' ' {
			continue
		}
		v = unicode.ToLower(v)
		if repeated[v] {
			return false
		}
		repeated[v] = true
	}
	return true
}
```

## Common suggestions

**Storage**

- A `map[rune]bool` is a straightforward way to store unique runes.  
  It makes it easier to check for the existence of keys:

```
if repeated[v] { ... }
```

instead of using the longer form:

```
if _, ok := repeated[v]; ok { ... }
```

- `map[rune]struct{}` uses less memory, but is more awkward to look up; 26 bytes for a map of `bool` is a price worth paying for the improved readability.
- `map[rune]int` is a reasonable approach where we return false when the count is more than 1, but this is wasteful of memory, and requires a more complicated `if` condition than the simple `if repeated`.
- Using an array for storage is an approach that will considerably improve the performance of the solution:

```
var alpha [26]bool
```

However later on in the code, some variation of the following will need to be adopted:

```
index := charVal - 'A'
if alpha[index] {
	return false
}
alpha[index] = true
```

Working directly with code points this way is both a clever and efficient way to solve the problem, at the expense of readability, with the added disadvantage that the `index` in this example would need further validation to ensure no bad characters are passed as an index.  
If the student goes this route we should suggest the `map[rune]bool` solution instead, and direct them to [Writing Slower Go Programs](https://bitfieldconsulting.com/golang/slower) for tips on when to trade off readability against performance (hint: hardly ever).

**Checking characters**

- Since the requirements only mention whitespace and hyphens, checking only for those is acceptable.
- `unicode.IsLetter()` is otherwise a great alternative that will catch all invalid/unwanted characters.

**Control flow**

A very common pattern is the following:

```
if unicode.IsLetter(v) {
	... // check map
}
```

This is a nice opportunity to point out the 'early return' pattern:

```
if !unicode.IsLetter(v) {
	continue
}
... // check map
```

and explain its advantages:

- The remaining code doesn't need to be indented, improving readability
- No need for a subsequent `else` clause, because we already returned or continued
- It's easier to read non-negative if conditions, and the action associated with the condition (`continue`) is right next to the condition itself in the source code, instead of many lines later.

To further support this point, we may refer the student to [Code: Align the happy path to the left edge](https://medium.com/@matryer/line-of-sight-in-code-186dd7cdea88).

## Talking points

- The storage is being used as a [Set](<https://en.wikipedia.org/wiki/Set_(abstract_data_type)>), so some time can be spent with the student discussing pros and cons of this data structure.
  We can also reference [Finding whether a Go map key exists](https://bitfieldconsulting.com/golang/map-key-exists) for some examples of using `bool` maps as sets.

## Mentoring Tools

- [Exalysis](https://github.com/exercism/exalysis) is a tool designed to help mentors of the Exercism Go track. It will watch the clipboard for Exercism download links, automatically download the student's solution, run the tests, check e.g. `gofmt` and `golint`, and make several helpful suggestions for the student based on static analysis of the code for common errors and problems. The results are copied to the clipboard, so all you need to do is paste the response, review it, edit it to add your own remarks, and submit.
