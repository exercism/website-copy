Your solution used `Date.parse(%<parameter.name>)`. This works, but isn't _intended_ to be used with a `Date` object. In fact, in order to work it first coerces the input value to a `string` and then parses it back into a date, which is unnecessary in this case.

It would be better to use `%<parameter.name>.getTime()` as [`Date#getTime`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime) doesn't coerce the input but works on the Date directly.
