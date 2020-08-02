# Isogram

This exercise further reinforces concepts introduced in previous exercises, regarding differences between `rune` and `string`.  
Students are encouraged to find ways to keep track of unique characters in the string.

As always, _Unformatted or unlinted code is a reason not to approve._

### Reasonable solutions

```
// Package isogram
package isogram

import "unicode"

// IsIsogram returns true if a word is an isogram
func IsIsogram(word string) bool {
	seen := make(map[rune]bool)
	for _, v := range word {
		if v == '-' || v == ' ' {
			continue
		}
		v = unicode.ToLower(v)
		if seen[v] {
			return false
		}
		seen[v] = true
	}
	return true
}
```

### Common suggestions

**Storage**

- A `map[rune]bool` is a straightforward way to store unique runes.
  It makes it easier to check for the existence of keys instead of using the longer form:

```
if _, ok := seen[v]; ok { ... }
```

- `map[rune]struct{}` uses less memory, but not by a wide margin.
- `map[rune]int` is an acceptable approach where we return false when the count is more than 1.
- Using an array for storage is an approach that will considerably improve the performance of the solution:

```
var alpha [26]bool
```

However later on in the code, something like the following will need to be adopted:

```
index := charVal - 'A'
if alpha[index] {
	return false
}
alpha[index] = true
```

Working directly with code points this way is both a clever and efficient way to solve the problem, at the expense of readability.  
If the student goes this route we may suggest the `map[rune]bool` solution, or at the very least to add a comment clarifying their intent.

**Checking characters**

- Since the requirements only mention whitespace and hyphens, checking only for those is acceptable.
- `unicode.IsLetter()` is otherwise a great alternative that will take care of all invalid/unwanted characters.

### Talking points

- The storage is being used as a [Set](<https://en.wikipedia.org/wiki/Set_(abstract_data_type)>), so some time can be spent with the student discussing pros and cons of this data structure.

### Mentoring Tools

- [Exalysis](https://github.com/exercism/exalysis) is a tool designed to help mentors of the Exercism Go track. It will watch the clipboard for Exercism download links, automatically download the student's solution, run the tests, check e.g. `gofmt` and `golint`, and make several helpful suggestions for the student based on static analysis of the code for common errors and problems. The results are copied to the clipboard, so all you need to do is paste the response, review it, edit it to add your own remarks, and submit.
