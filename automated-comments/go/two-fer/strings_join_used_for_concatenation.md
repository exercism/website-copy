`strings.Join` is perfect if the data already comes in the form of a `[]string`.
Take a look at `fmt.Sprintf` for this use case; it's a very powerful way of building up strings from multiple pieces.

In case of simple concatenations, the `+` operator is a very fast alternative.
