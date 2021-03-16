# Mentoring

This exercise introduces [`Date`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date).

### Reasonable solutions
```javascript
const GIGASECOND_IN_MS = (10 ** 9) * 1000

export function gigasecond(date) {
  return new Date(date.getTime() + GIGASECOND_IN_MS)
}
```

Variations include using `const` with an arrow function or `module.exports`.

### Common suggestions
- Prefer `Date#getTime` over [`Date#valueOf`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/valueOf). They are functionally equivalent, but
  `valueOf` is marked as follows: "This method is usually called internally by JavaScript and not explicitly in code.",
  which is true.
- Suggest immutability over solutions mutating the input like the following one:
  ```javascript
  export function gigasecond(date) {
    date.setSeconds(date.getSeconds() + GIGA_SECOND)
    return date
  }
  ```

### Talking points
- [Unix/UTC time](https://en.wikipedia.org/wiki/Unix_time). This is why `getTime` is preferred over any manual calculation.
- A good moment to introduce [`const`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const) and explain local [`export`](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export), but not a necessity.
- `setSeconds` only works because it _rolls over_, but it wasn't meant to be used like this. Its function is to set the
  seconds component of the date.

### Response template
You can use the template below to respond to a student. If there are big issues don't approve the solution. If they
didn't convert to milliseconds, make sure you change the `12` to `9` and the name as well.

> Hi there,
>
> This is _great_.
>
> - I would suggest to extract that number into a named `const` as to remember
>   what it is in a years time (`GIGASECOND_IN_MS`). You might also want to
>   write it as `10 ** 12` or `Math.pow(10, 12)`.
> - Did you know that [`new Date(value)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date#Syntax) also takes a number that is the
>   unix time in milliseconds?
> - Prefer [`Date#getTime`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime) over [`Date#valueOf`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/valueOf). They are
>   functionally equivalent, but `valueOf` is marked as follows: "This method
>   is usually called internally by JavaScript and not explicitly in code.".
> - Finally, `Date.parse(date)` is not a good candidate as it's supposed to
>   work with strings only. Instead, have a look at [`Date#getTime`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/getTime).
>   You should be able to make that work :D
>
> I am approving this, and as you know you may submit further iterations. If
> not, good luck on the next exercise!
