The student is using `parseFloat` or `parseInt` to convert back to a number.
Perhaps they need an introduction to or reminder of [`Number(...)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object).
The `parseXXX` family is _great_ if you do not know if the input is a number,
but when you know it, it's better to use the stricter `Number(...)` function.
