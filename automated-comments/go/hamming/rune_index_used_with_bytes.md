You are iterating over `runes` but you are using the index to get single `bytes` from the string. 
This is working fine as the exercise only requires you to handle `ascii` characters. 
Try adding the following test to see what happens if `non-ascii` characters get involved:

```go
{
	s1:          "aüa",
	s2:          "aÃa",
	want:        1,
	expectError: false,
}
```
