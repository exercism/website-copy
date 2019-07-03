Iterating over `runes` and using the index to get single `bytes` is safe in this case, 
because the input is all ASCII characters. 
To see what happens when non-ASCII characters are used, add this test case:

```go
{
	s1:          "aüa",
	s2:          "aÃa",
	want:        1,
	expectError: false,
}
```
