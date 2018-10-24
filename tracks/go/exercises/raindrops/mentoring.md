# Raindrops

This is the third core exercise in the go track to receive feedback from a mentor. It is less about learning new concepts but more about deepening the already acquired knowledge. To some the conversion of an `int` to `string` and the modulus operator `%` are new.

This may be an excellent place to talk about the go tooling again -- especially if the tools were not applied (`gofmt`, `golint`, etc).

## Reasonable solutions

The exercise can be solved with `if` statements and `string` concatenation:


```
// Convert implements raindrop speech
func Convert(i int) string {
	var res string
	if i%3 == 0 {
		res += "Pling"
	}
	if i%5 == 0 {
		res += "Plang"
	}
	if i%7 == 0 {
		res += "Plong"
	}

	if res == "" {
		res = strconv.Itoa(i)
	}

	return res
}
```

## Common suggestions

The most common feedback revolves around:

* General programming things (working with strings, map iteration)
* Readability (formatting, comments, linting)

**Map: random iteration** 
* are they defining static values (map, slice) in the function? Suggest moving them to package level.
* are they using a `map` to hold the cases? This gets complicated as they need to somehow make sure the order is correct. From the [specs](https://golang.org/ref/spec#For_statements): "The iteration order over maps is not specified and is not guaranteed to be the same from one iteration to the next." You could direct them towards using `for i := 3; i < 8; i += 2` or a for loop that iterates the slice `[]int{3, 5, 7}`

**Control flows**
* are they using `if { return ..} else { return ..}`? Point them to `golint` which will suggest to remove the else and outdent its block.
* are they using a `for i; .. i++` loop? Check what range they are iterating. The most optimal loop iterates `for i := 3; i < 8; i += 2`. Iterating to given `number` (as many do) is not necessary.

**Strings: concatenation and conversion**
* are they using `strconv.FormatInt`? You can point them to `strconv.Itoa` as being more convenient (no `int64` conversion needed, no second parameter).
* are they using `fmt.Sprintf` or `fmt.Sprint`? These functions need reflection to check the type which makes it much slower. You could suggest using `strings.Itoa`.
* are they using a slice and `strings.Join`? You could mention appending to the string with `+=` as a simpler method.
* are they using a `strings.Builder`? You could mention appending to the string with `+=` as a simpler method or -- if they seem to be more advanced or are very hungry -- as an option that consumes ~2.5 times less memory and is also slightly faster.

**Inconsistent formatting: mention `gofmt`**
* Did they not run `gofmt`? By now, if you spot that they haven't run `gofmt`, it is advisable to require that they run it before approving.  Gently point it out (https://blog.golang.org/go-fmt-your-code) and maybe mention that this is the accepted standard and that all professional or open source projects you contribute to will require you to run it.

**Comments: the Go community has strong opinions and great guidelines**
* Do they not have comments at all? Suggest that they try out `golint`. Maybe something like _I'd recommend taking a moment to run `golint` on your package, and follow the trail to making the linter happy.  Linting is definitely not something that people would recommend breaking the build for, but `golint` tends to complain about things that the Go community has strong preferences about, so it can be a really useful tool for learning about making your Go look more Go-ish._
* Do they have comments that don't follow the linting guidelines? Suggest `golint`.
* Do they have comments that pass `golint` but don't end with a period? Potentially point them to [CodeReviewComments](https://github.com/golang/go/wiki/CodeReviewComments#comment-sentences) wiki, which suggests that doc comments should be full sentences, ending with a period.

## Talking points

* `map` iteration order: See [specs](https://golang.org/ref/spec#For_statements). Since the order in which the map is iterated matters in this exercise a map is not a perfect fit here. If one wants to iterate, using a `for i := 3; i < 8; i += 2` or iterating a slice is a better fit.
* `golint` as a great helper to write idiomatic go code and why it is so important for the go community: all go code looks the same, `godoc` uses comments to auto-create documentation, etc.
