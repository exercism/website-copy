Converting a `byte` to a `rune` works perfectly in the context of this exercise as there are only ASCII letters in DNA strands.
ASCII characters consist of one `byte` each. As soon as non-ASCII characters get involved this method of comparison breaks as those characters consist of 
up to 4 bytes.

For an additional challenge you can try creating more tests with non-ASCII characters and see what happens.
