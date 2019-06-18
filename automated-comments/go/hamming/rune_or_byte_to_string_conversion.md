As you know, using `range` over a `string` gives you a `rune`, but indexing into a `string` returns a `byte` value. The difference is described in more detail here: [Strings, bytes, runes and characters in Go](https://blog.golang.org/strings).

There is no need to convert runes and bytes to string to compare them. You should decide if you want to compare `runes` or `bytes`.
