# use zero values on error return

By convention, when returning an `error` value, other values are not used,
and it's considered idiomatic to return the [zero value](https://golang.org/ref/spec#The_zero_value) in this situation.
The `error` value makes using an invalid "out of band" value to signal an error redundant in Go.
