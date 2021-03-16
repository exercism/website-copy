# extra name variable created

Creating an extra variable to hold the name is unnecessary, as Go does not pass variables by reference.
Re-assigning to `name` will not change the value beyond the scope of the `ShareWith` function.
Since Go does not provide a way of providing default values to function parameters,
it is a common idiom in Go to re-assign the value to provide a default.
