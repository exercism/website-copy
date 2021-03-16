# lossy rune to byte conversion

The `rune` to `byte` conversion is safe here, because the input string contains only ASCII characters.
Go `runes` can consist of multiple `bytes`, though, which can cause trouble when dealing with non-ASCII characters.

For more on this, read [Strings, bytes, runes and characters in Go](https://blog.golang.org/strings) on the Go blog.

To see this in practice, add a test containing non-ASCII characters.
