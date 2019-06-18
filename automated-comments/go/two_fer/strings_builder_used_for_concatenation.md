`strings.Builder` is a highly optimized way to build complex strings. 
In simple cases like this using `fmt.Sprintf` is the preferred way. It has a lot
of formatting options making it very flexible far beyond simple concatenation.

If you want speed try using the `+` operator. It even trumps the `strings.Builder` 
in speed on simple use cases like this.
