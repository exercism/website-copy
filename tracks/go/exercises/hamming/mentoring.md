# Hamming

_Hamming_ is the first exercise in the Go track that requieres to use a `for` loop and creation of an `error`.
Although this is about `for` loops students that submit working solutions have that nailed.

## Reasonable Solutions

This can be solved by using a loop with counter or a loop with `range`. This solution uses a `for .. range`:

```
// Package hamming provides the hamming algorithm
package hamming

import "errors"

// Distance calculates the hamming distance between two strings
func Distance(a, b string) (int, error) {
	if len(a) != len(b) {
		return 0, errors.New("length is not equal")
	}

	var count int
	for i, s := range []byte(a) {
		if s != b[i] {
			count++
		}
	}

	return count, nil
}
```

## Common suggestions

It might be good to confirm this exercise as soon as the solution is within reasonable scope. That way 
students can keep their enthusiasm and continue on the main track. Many students will respond to the
improvement suggests even if the solution is approved.

The most common feedback revolves around:

* Readability (formatting, comments, code structure)

**Error and error message: correct instantiation and concise error message**
* Does the error message describe the problem? In Go standard error the error message is all we have. So it should be concise describing the problem in a non-generical way.
* Is the error formatted correctly? For example the error [should not be capitalized or have punctuation](https://github.com/golang/go/wiki/CodeReviewComments#error-strings)
* Did they use a combination of `errors.New` and `fmt.Sprintf`? Hint at `golint` and `fmt.Errorf`.

**Comments: the Go community has strong opinions and great guidelines**
* Do they not have comments at all? Suggest that they try out `golint`. Maybe something like _I'd recommend taking a moment to run `golint` on your package, and follow the trail to making the linter happy.  Linting is definitely not something that people would recommend breaking the build for, but `golint` tends to complain about things that the Go community has strong preferences about, so it can be a really useful tool for learning about making your Go look more Go-ish._
* Do they have comments that don't follow the linting guidelines? Suggest `golint`.
* Do they have comments that pass `golint` but don't end with a period? Potentially point them to [CodeReviewComments](https://github.com/golang/go/wiki/CodeReviewComments#comment-sentences) wiki, which suggests that doc comments should be full sentences, ending with a period.

**Code structure: is the code easily readable?**
* Did they wrap the `for` loop in the `if`? This is completely valid but less readable: the error is returned at the bottom far away from the if statement.
* Did they use `if .. else` with returns in each of them? Hint at `golint` which suggests to remove the else and outdent the second block.

**Speed: Did they add unnecessary code which slows down the execution time?**
* Did they add a `if a == b` statement? This is not needed and will slow down considerably.

**Talking points**
* `rune` vs `byte` and why iterating over a string with `range` returns runes: [Strings, bytes, runes and characters in Go](https://blog.golang.org/strings)

