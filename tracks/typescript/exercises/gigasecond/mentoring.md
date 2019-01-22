This exersize introduces [`Date`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date).

```typescript
const GIGASECOND_IN_MS = (10 ** 9) * 1000

/**
 * Adds a gigasecond (10^9) to the input {date}
 *
 * @export
 * @param {Readonly<Date>} date
 * @returns {Date} the date + 10^9 seconds
 */
export function gigasecond(date: Readonly<Date>): Date {
  return new Date(date.getTime() + GIGASECOND_IN_MS)
}
```

### Common suggestions
The following don't warrant a dissaproval but can be mentioned:
- It is [good practise](https://github.com/DefinitelyTyped/DefinitelyTyped#common-mistakes) to mark input variables you don't alter with [`Readonly<T>`](https://www.typescriptlang.org/docs/handbook/advanced-types.html#mapped-types)
- In public APIs, explicitly setting the return type guards against unwanted changes.

### Talking points
- [Unix/UTC time](https://en.wikipedia.org/wiki/Unix_time). This is why `getTime` is preferred over any manual calculation.
- A good moment to introduce [`const`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const) and explain local [`export`](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export), but not a necessity.
- `Readonl
