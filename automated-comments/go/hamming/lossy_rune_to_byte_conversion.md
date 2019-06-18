You are converting a `rune` to a `byte`. Go `runes` can consist of multiple `bytes`, so this conversion can cause you problems if you have to deal with non-ASCII characters. However, in this case it's OK, because the input string contains only ASCII (single-byte) characters.

To get a deeper understanding of these issues you might like to read [Strings, bytes, runes and characters in Go](https://blog.golang.org/strings) on the Go blog.
    
You can also add more tests to  this exercise containing non-ASCII characters and see what happens.
