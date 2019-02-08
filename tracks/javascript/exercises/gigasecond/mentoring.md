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
