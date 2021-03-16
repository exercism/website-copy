# prefer number over parse

The student is using `parseFloat` or `parseInt` to convert back to a number.
Perhaps they need an introduction to or reminder of [`Number(...)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Convert_numeric_strings_and_null_to_numbers ).
The `parseXXX` family is _great_ if you do not know if the input is a number,
but when you know it, it's better to use the stricter `Number(...)` function.
