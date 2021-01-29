Use [`Date#getTime`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime),
as `Date.parse(%{parameter.name})` is not a good candidate.

`Date.parse` is supposed to be called with a `string`, and therefore not
_intended_ to be used like this. The reason it does work is because `Date.parse`
first coerces the input value to a `string` and then parses it back into a date.
These extra conversions are unnecessary.
