This exersize introduces [`Date`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date).

```typescript
const GIGASECOND_IN_MS = (10 ** 9) * 1000

export default class Gigasecond {

  private futureDate: Date

  /**
   * Create a new Gigasecond instance
   * @param {Readonly<Date>} date the input date
   */
  constructor(date: Readonly<Date>) {
    this.futureDate = new Date(date.getTime() + GIGASECOND_IN_MS)
  }

  /**
   * The origina input date plus one gigasecond
   * @returns {Date} the future date
   */
  date(): Date {
    return this.futureDate
  }
}
```

### Common suggestions
The following don't warrant a dissaproval but can be mentioned:
- It is [good practise](https://github.com/DefinitelyTyped/DefinitelyTyped#common-mistakes) to mark input variables you don't alter with [`Readonly<T>`](https://www.typescriptlang.org/docs/handbook/advanced-types.html#mapped-types)
- In public APIs, explicitly setting the return type guards against unwanted changes.

### Talking points
- [Unix/UTC time](https://en.wikipedia.org/wiki/Unix_time). This is why `getTime` is preferred over any manual calculation.
- A good moment to introduce [`const`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const) and explain local [`export`](https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export), but not a necessity.
- `private` since there is an accessor (`date()`).
