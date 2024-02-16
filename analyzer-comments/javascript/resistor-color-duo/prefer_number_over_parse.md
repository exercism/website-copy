# prefer number over parse

The `parseXXX` family is _great_ to convert an input to a number
if you do not know if the input is a number,
but when you know it, it's better to use the stricter
[`Number(...)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Convert_numeric_strings_and_null_to_numbers ) function.
