# Mentoring

This exercise introduces [`Date`][ref-date].

### Reasonable solutions

Their are two optimal solutions. 

The `Gigasecond` class can return an  immutable value, which means it's 
calculated once. To enforce this behaviour, it is _recommendable_ to [`freeze`][ref-freeze]
the value, so that consumers can not accidentally break the code elsewhere,
for example by casting back to a non-readonly value.

```typescript
const GIGASECOND_IN_MS = (10 ** 9) * 1000

export default class Gigasecond {

  private futureDate: Readonly<Date>

  constructor(date: Readonly<Date>) {
    this.futureDate = Object.freeze(new Date(date.getTime() + GIGASECOND_IN_MS))
  }

  date(): Readonly<Date> {
    return this.futureDate
  }
}
```

The other approach is calculating the new date on invocation of the `date()`
function, which ensures a new, fresh, value is returned each call. In this case
the return value is **not** readonly.

```typescript
const GIGASECOND_IN_MS = (10 ** 9) * 1000

export default class Gigasecond {

  constructor(private readonly date: Readonly<Date>) { }

  date(): Date {
    return new Date(this.date.getTime() + GIGASECOND_IN_MS)
  }
}
```

### Common suggestions

- Prefer `Date#getTime` over [`Date#valueOf`][ref-value-of]. They are functionally equivalent, but
  `valueOf` is marked as follows: "This method is usually called internally by JavaScript and not explicitly in code.",
  which is true.
  
The following don't warrant a dissaproval but can be mentioned:

- It is [good practise][ref-common-mistakes] to mark input variables you don't alter with [`Readonly<T>`][ref-mapped-types]
- In public APIs, explicitly setting the return type guards against unwanted changes.
- If your instance breaks if a return-value is modified, mark it as `Readonly<T>`, and consider _freezing_ the value.
- If you don't want to return `Readonly<T>` values, make sure it's a fresh instance on each call.

### Talking points

- [Unix/UTC time][wiki-unix]. This is why `getTime` is preferred over any manual calculation.
- A good moment to introduce [`const`][ref-const] and explain local [`export`][ref-export], but not a necessity.
- `private` property since there is an accessor (`date()`).

[wiki-unix]: https://en.wikipedia.org/wiki/Unix_time
[ref-const]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/const
[ref-export]: https://developer.mozilla.org/en-US/docs/web/javascript/reference/statements/export
[ref-mapped-types]: https://www.typescriptlang.org/docs/handbook/advanced-types.html#mapped-types
[ref-value-of]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date/valueOf
[ref-common-mistakes]: https://github.com/DefinitelyTyped/DefinitelyTyped#common-mistakes
[ref-freeze]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/freeze
[ref-date]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date
