# Two Fer

_Two Fer_ is the first core exercise after _Hello, World_. _Hello, World_ is auto-approved, so _Two Fer_ is the first exercise where someone will be blocked until a mentor approves their exercise, and also likely the first feedback they've ever gotten on their Go code.

This is also going to be the most common exercise that we are asked to mentor, since some people will drop off after submitting just the one.

The goal of the exercise is to get acquainted with Go. This is often an excellent place to start introducing people to the tooling (`gofmt`, `golint`, `go doc`, `go vet`, etc).

## Reasonable solutions

We don't have any clear guidelines around when to approve. Some people have been adding comments and approving straight away, others have been approving when the solution has a nice, Go-ish shape (a small conditional that isolates the smallest difference, and a single line of string formatting).


```
// Package twofer distributes resources.
package twofer

import "fmt"

// ShareWith explains how a resource will be shared.
// If nobody is mentioned by name, then the other half
// goes to 'you'.
func ShareWith(name string) string {
	if name == "" {
		name = "you"
	}
	return fmt.Sprintf("One for %s, one for me.", name)
}
```

## Common suggestions

One mentor recommended to focus on a single thing, and only add other improvements as "food for thought" that the author can take with them as they move on to the next exercise.

The most common feedback revolves around:

* Readability (formatting, comments)
* Language-specific features/quirks (fmt package, tooling, go-specific idioms with naming or commenting)
* General programming things (compound variable names, minimal conditionals)

**The conditional: isolate the smallest possible difference**
* Is there duplicated content? Sometimes this will be two branches, sometimes this will be one branch with the whole phrase in it, and then the phrase repeated after the conditional.
* Are they re-assigning the param to a local variable? You can point out that they have two variables doing the same thing, e.g. `input` and `value` are both doing the same thing. Can you get away with just having one of them?

**String concatenation: hint towards the `fmt` package**
* are they using a slice and strings.Join()?
* are they using `+` to concatenate? It's perfectly legit to see `+`, just a bit more common to see `fmt`, and worth getting used to. That said, `+` is shorter and avoids an import.
* point them towards `fmt` package as the more conventional choice if not using it. Maybe not point straight to which function, it's often useful to let people explore a bit and find it on their own.
* are they using `%v` instead of `%s` for `fmt.Sprintf`? Can suggest that `%s` is probably more common when interpolating a string.

**The parameter name: short, concise, but not cryptic**
* If they have a single-letter variable name that is not `s` It can be worth asking what it stands for. Go is totally fine with short variable names, but we shouldn't be scratching our heads to figure out what it stands for. `n string` is not obvious (n == name?), `p string` also (p== person??). If it's not obvious from the context, then it could be worth suggesting that they write the whole word out.
* If they have a compound name (two or more words), it could be worth talking about how Go values conciseness. One trick is to ask yourself if each part of the name makes a meaningful distinction. If you can drop either the suffix or the prefix without losing meaning, then maybe go for the shorter name.

**Inconsistent formatting: introduce `gofmt`**
* Did they not run `gofmt`? This is harder to detect right now unless it's blatantly badly formatted, but if it's clear that `gofmt` hasn't been run, it's worth gently pointing to it (https://blog.golang.org/go-fmt-your-code), and maybe mentioning that this is the accepted standard, and that all professional or open source projects that you contribute to will require you to run it.

**Comments: the Go community has strong opinions and great guidelines**
* Did they leave in all the stub comments? Gently remind them that this adds mental overhead for the reader, since we have to read all of it before deciding that it's irrelevant.
* Do they not have comments at all? Suggest that they try out `golint`. Maybe something like _I'd recommend taking a moment to run `golint` on your package, and follow the trail to making the linter happy.  Linting is definitely not something that people would recommend breaking the build for, but `golint` tends to complain about things that the Go community has strong preferences about, so it can be a really useful tool for learning about making your Go look more Go-ish._
* Do they have comments that don't follow the linting guidelines? Suggest `golint`.
* Do they have comments that pass `golint` but don't end with a period? Potentially point them to [CodeReviewComments](https://github.com/golang/go/wiki/CodeReviewComments#comment-sentences) wiki, which suggests that doc comments should be full sentences, ending with a period.

## Talking points

* trade-off between `fmt.Sprintf` and `+`, `fmt` is very common and idiomatic, but `+` is shorter and avoids and import.
