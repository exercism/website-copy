There is no need to create an extra variable to hold the name. Go does not pass variables by reference. 
You will therefore not change the `name` variable beyond the scope of the `ShareWith` function.

Go does not have default values. Overwriting the `name` with `you` is setting a default value for `name` if it is empty.
