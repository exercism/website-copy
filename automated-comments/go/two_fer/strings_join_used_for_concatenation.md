This solution uses `strings.Join` to build a string. If you do not already
have a `[]string` this feels like a detour. You might like to look at the 
`fmt.Sprintf` function instead; it's a very powerful way of building up strings 
from multiple pieces.

If you only need to concatenate strings, you can also use the `+` operator to do 
this instead of calling `fmt.Sprintf`.
