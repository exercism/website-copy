# Hamming

_Hamming_ is the first exercise in the Go track that requires to use a `for` loop and creation of an `error`.
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
* Is the error message empty or vague? In Go the returned error can provide context for where the error occurred and why, so it should concisely and specifically describe the problem.
* Is the error formatted correctly? For example the error [should not be capitalized or have punctuation](https://github.com/golang/go/wiki/CodeReviewComments#error-strings).
* Did they use a combination of `errors.New` and `fmt.Sprintf`? Hint at `golint` and `fmt.Errorf`.
* Did they use `fmt.Errorf` for a non-interpolated string? It may be worth suggesting they use `errors.New` in these cases to explicitly indicate that no interpolation will be occurring. Encouraging early exposure to the `errors` package might start benefitting them immediately, e.g., `errors.Wrap`. 
* Did they return `-1` or `0` in the error case? Point out that in some languages, returning an out of band value (like -1) is necessary since you can't have multiple return values, but that in Go, the convention is to return an error and the zero value.

**Comments: the Go community has strong opinions and great guidelines**
* Do they not have comments at all? Suggest that they try out `golint`. Maybe something like _I'd recommend taking a moment to run `golint` on your package, and follow the trail to making the linter happy.  Linting is definitely not something that people would recommend breaking the build for, but `golint` tends to complain about things that the Go community has strong preferences about, so it can be a really useful tool for learning about making your Go look more Go-ish._
* Do they have comments that don't follow the linting guidelines? Suggest `golint`.
* Do they have comments that pass `golint` but don't end with a period? Potentially point them to [CodeReviewComments](https://github.com/golang/go/wiki/CodeReviewComments#comment-sentences) wiki, which suggests that doc comments should be full sentences, ending with a period.

**Code structure: is the code easily readable?**
* Did they wrap the `for` loop in the `if`? This is completely valid but less readable: the error is returned at the bottom far away from the if statement.
* Did they use `if .. else` with returns in each of them? Hint at `golint` which suggests to remove the else and outdent the second block.
* Did they use a 3-part `for` loop, e.g. `for i := 0; i < len(a); i++` that's common in other languages? They might appreciate finding out about Go's more concise `for i:= range a` shortcut, which can help avoid off-by-one errors.


**Speed: Did they add unnecessary code which slows down the execution time?**
* Did they add a `if a == b` statement? This is not needed and will slow down considerably.

## Talking points

* `rune` vs `byte` and why iterating over a string with `range` returns runes: [Strings, bytes, runes and characters in Go](https://blog.golang.org/strings)

## Mentoring Tools

* [Exalysis](https://github.com/exercism/exalysis) is a tool designed to help mentors of the Exercism Go track. It will watch the clipboard for Exercism download links, automatically download the student's solution, run the tests, check e.g. `gofmt` and `golint`, and make several helpful suggestions for the student based on static analysis of the code for common errors and problems. The results are copied to the clipboard, so all you need to do is paste the response, review it, edit it to add your own remarks, and submit.
