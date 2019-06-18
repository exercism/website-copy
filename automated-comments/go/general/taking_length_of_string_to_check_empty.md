This solution is taking the length of a `string` to check if it empty. This does make sense in some
programming languages where a string with the length of `0` can be empty, not set, etc. 
In `Go` a `string` of zero length can only be empty. The proper way to test if a `string` is empty would be:

```go
if s == "" {
	// do something
}
```
