`strings.Join` is only normally used if the data is of type `[]string`.
In other situations, it is more common to use `fmt.Sprintf`, which is a very powerful way of building up strings from multiple pieces.
Could you try updating your solution to use that?
