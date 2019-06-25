When your function returns an `error`, this tells the caller that the other return value shouldn't be used. 
Since it doesn't actually matter what you return in that case, the convention is to return the [zero value](https://golang.org/ref/spec#The_zero_value).
In languages that don't allow multiple return values from functions, you often need to use an invalid 'out-of-band' value to signal an error, such as `-1`. That's not necessary in Go.

By convention, when returning an `error` value, other values are not used,
and it's considered idiomatic to return the [zero value](https://golang.org/ref/spec#The_zero_value) in this situation.
The `error` value makes using an invalid "out of band" value to signal an error redundant in Go.
