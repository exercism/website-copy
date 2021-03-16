# dont use date value

Use [`Date#getTime`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime)
instead of [`Date#valueOf`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/valueOf).
They are functionally equivalent, but `valueOf` is marked as follows:

> This method is usually called internally by JavaScript and not explicitly in
> code.
