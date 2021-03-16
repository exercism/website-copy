# Mentoring

The point of this exercise is to teach the student to use:
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo
- [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)
- [Typing functions](https://www.typescriptlang.org/docs/handbook/functions.html#typing-the-function)
- [Type inference](https://www.typescriptlang.org/docs/handbook/functions.html#inferring-the-types)
- [Boxed types](https://www.typescriptlang.org/docs/handbook/declaration-files/do-s-and-don-ts.html)

## Reasonable solutions

```typescript
function isLeapYear(year: number) {
    return year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0)
}

export default isLeapYear
```

```typescript
function isLeapYear(year: number) {
    return !(year % 4) && (year % 100 || !(year % 400))
}

export default isLeapYear
```

A student may export inline `export default function`, a student may substitute the `functions` with a `const`, and a student may use the short-hand `const isLeapYear = (year: number) => ...`.

A student may explicitly type the return value as `boolean`.

## Common suggestions
- There are two types of students that give different responses than the reasonable solutions:
  - A student explicitly returns `true` and `false` and doesn't use [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators) to combine multiple expressions,
  - A student comes up with something "clever", that is usually either unreadable at first sight or unmaintable, or both.
- `tslint` will _not_ warn when mixing `&&` and `||`, which ís a feature of `eslint`, adding parentheses here is recommended:
  - _order of operation_ matters:
    - 75% of all years *cannot* be leap years because they are not multiples of 4; test `year % 4 === 0` first
    - 98.97% of all leap years are multiples of 4 that are not multiples of 100; test `year % 100 !== 0` second
    - 1.03% of all leap years are multiples of 4 that are also multiples of 100 and 400; test `year % 400 === 0` third
    - A student might be missing parentheses:
      ```typescript
      return year % 4 == 0 && year % 100 != 0 || year % 400 == 0
      ```
      Albeit correct in output, the check `year % 400` is executed for all years that don't match `year % 4 == 0`, and for these (75% of all years), always returns `false`, because if something is not divisible by 4 it _can not_ be divisible by 400. This is making a redundant check.
    - A student might have inversed the test order:
      ```typescript
      return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
      ```
      Albeit correct in output, the check `year % 400` is _only_ true for `1.03%` years that are divisible by 4. Always try to put the common path first. Logically, following the instructions putting this check first is **incorrect**.
  - _order of evaluation_ matters: Refer to [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence). In Javascript and TypeScript logical AND (`&&`) always goes before logical OR (`||`). Adding parentheses clears up any confusion, and groups the second and third test together.
- There are only two cases that return true:
  - a year MUST be a multiple of four AND NOT be a multiple of 100
  - a year MUST be a multiple of 400 (implies multiple of 4 and 100)
- Eliminate duplicate work; no year should ever have to be checked multiple times for the same condition.
- If a student uses an explicit return type, do _not_ suggest them to remove it. It's _not_ wrong. However you can teach them about [type inference](https://www.typescriptlang.org/docs/handbook/functions.html#inferring-the-types). Explicitly typing makes the type rigid which e.g. can be great for APIs (so the return type is guaranteed), but can be a burden for internal refactoring.
- If a student uses `Boolean` or `Number`, they _must_ use the unboxed, primitive variant. Explain to never use the types `Number`, `String`, `Boolean`, or `Object`. These types refer to non-primitive boxed objects that are almost never used appropriately in JavaScript code.
- Style suggestions:
  At this point in the track you may want to indicate the usage of [`tslint`](https://palantir.github.io/tslint). A mentor should not disapprove code based solely on issues with the style, but should always encourage the project (`tslint.config`) rules:
  - The [`semicolon`](https://palantir.github.io/rules/semicolon/) rule is set to `true`, `"never"`, which prefers [Automatic Semicolon Insertion](http://www.ecma-international.org/ecma-262/6.0/index.html#sec-automatic-semicolon-insertion)
  - The [`variable-name`](https://palantir.github.io/tslint/rules/variable-name/) rule limits variable names by not allowing keywords/types to be a variable name. A variable named `number` is therefore not allowed.

## Talking points
* [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo. This usually does not need explaining.
* [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators), especially `&&` and `||`. If they use the binary forms, explain how [short-circuit](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Short-circuit_evaluation) evaluation works.
* [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence): unlike some other languages, logical AND (`&&`) _always_ has a **higher** precedence than logical OR (`||`).
* Typescript specifics: [Typing functions](https://www.typescriptlang.org/docs/handbook/functions.html#typing-the-function), [Type inference](https://www.typescriptlang.org/docs/handbook/functions.html#inferring-the-types) and [Boxed types](https://www.typescriptlang.org/docs/handbook/declaration-files/do-s-and-don-ts.html).
* Logical operators (`&&`, `||`) are more idiomatic than `if ... return ...`.
* Maintainability and performance:
  Something like this ís readable and maintainable, but if a student submits this, point out resources (functions are created each invocation) and returning expression evaluations:

  ```typescript
  function isDivisibleBy(x: number) {
    return (mod: number) => x % mod === 0
  }

  const isLeapYear = (year: number) => {
    const isDivisibleByFn = isDivisibleBy(year)
    const by4 = isDivisibleByFn(4)
    const by100 = isDivisibleByFn(100)
    const by400 = isDivisibleByFn(400)
    let isLeapResult = Boolean(by4 && !by100)
    if (by400) {
      isLeapResult = true
    }
    return isLeapResult
  };

  export default isLeapYear
  ```

  In this example, each invocation `isDivisibleFn` is recreated, which can be fixed by inversing the curry; and all values are calculated before they are used. In fact, when `by400` is true, the rest doesn't matter, so it's a waste of CPU cycles. This solution can still be used but changed to fix all these issues:

  ```typescript
  function isDivisibleByFn(mod: number) {
    return (x: number) => x % mod === 0
  }

  const by4 = isDivisibleByFn(4)
  const by100 = isDivisibleByFn(100)
  const by400 = isDivisibleByFn(400)

  const isLeapYear = (year: number) => by400(year) || (by4(year) && !by100(year))

  export default isLeapYear
  ```
