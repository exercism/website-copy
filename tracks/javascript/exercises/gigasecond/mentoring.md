This exersize introduces [`Date`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date).

### Reasonable solutions
```javascript
// @ts-check

const GIGASECOND_IN_MS = (10 ** 9) * 1000

/**
 * Adds a gigasecond (10^9) to the input {date}
 *
 * @export
 * @param {Date} date
 * @returns {Date} the date + 10^9 seconds
 */
export function gigasecond(date) {
  return new Date(date.getTime() + GIGASECOND_IN_MS)
}
```

### Talking points
- [Unix/UTC time](https://en.wikipedia.org/wiki/Unix_time). This is why `getTime` is preferred over any manual calculation.
- A good moment to introduce [`const`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const) and explain local [`export`](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export), but not a necessity.
