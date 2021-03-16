# signature not optimal

Looking at the tests, the function `gigasecond(...)` only receives one
parameter. Remove the additional parameters from the definition of `gigasecond`,
as the value of those extra parameters will always be `undefined`, or
be a default value as currently defined in the signature.

