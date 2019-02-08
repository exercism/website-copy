The point of this exercise is to teach the student to use:
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo
- [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)

### Reasonable solutions

```javascript
export const isLeap = (year) => year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0);
```
Variations check for truthy `year % m` and falsy `(!year % m)`:
```javascript
export const isLeap = (year) => !(year % 4) && year % 100 || !(year % 400);
```

```javascript
  function isDivisibleBy4(number) {
    return number % 4 === 0;
  }

  function isDivisibleBy100(number) {
    return number % 100 === 0;
  }

  function isDivisibleBy400(number) {
    return number % 400 === 0;
  }

  export const isLeap = year => isDivisibleBy4(year) && (!isDivisibleBy100(year) || isDivisibleBy400(year))
  ```

### Common suggestions
- There are two types of students that give different responses than the reasonable solutions:
  - A student explicitly returns `true` and `false` and/or doesn't use [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators) to combine multiple expressions,
  - A student comes up with something "clever", that is usually either unreadable at first sight or unmaintable, or both.
- If there are more than two "returns" or more than three "tests", suggest that there are just two cases that return `true`:
  - A year is a multiple of 4 *and not* 100
  - A year is a multiple of 4, 100, and 400
- If the order of the tests is not `disivible by 4`, `divisible by 100`, `divisible by 100`, explain that the _order of operations_ matter:
  - 75% of all years *cannot* be leap years because they are not multiples of 4; test the common path `year % 4 === 0` first.
  - 98.97% of all years that are multiples of 4 are not multiples of 100; test `year % 100 !== 0` second.
  - 1.03% of all years that are multiples of 4 are also multiples of 100 and 400; test `year % 400 === 0` third.
- If a student does _not_ use parentheses, and the structure is `div?(4) && !div?(100) || div?(400)`, explain that the _order of evaluation_ matters:
  - [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)
  - [Short circuit evaluation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Short-circuit_evaluation)
- Eliminate duplicate work: no year should ever have to be checked multiple times for the same condition; encourage students to resolve this by consolidating and/or reordering conditions.

### Talking points
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo. This usually does not need explaining.
- [Logical operators (`!`, `&&`, and `||`)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators). If they use the binary forms `&`, `|`, explain how [short-circuit](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Short-circuit_evaluation) evaluation works.
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence): unlike other languages, logical AND (`&&`) _always_ has a **higher** precedence than logical OR (`||`).
- [truthy](https://developer.mozilla.org/en-US/docs/Glossary/Truthy) and [falsy](https://developer.mozilla.org/en-US/docs/Glossary/Falsy) values in JavaScript
- Differences between loose value equality (`==`) and same-value equality (`===`)
- Maintainability and performance:
  Something like this ís readable and maintainable, but if a student submits this, point out resources (functions are created each invocation) and returning expression evaluations as in this example, each invocation `isDivisibleFn` is recreated, which can be fixed by inversing the curry; and all values are calculated before they are used. In fact, when `by400` is true, the rest doesn't matter, so it's a waste of CPU cycles. Applying the suggestions to this works the same when it comes to logical operators, _order of operations_ and _order of evaluation_ as per the second reasonable solution.

  ```javascript
  function isDivisibleBy(number) {
    return mod => number % mod === 0;
  }

  export const isLeap = year => {
    const isDivisibleByFn = isDivisibleBy(year);
    const by4 = isDivisibleByFn(4);
    const by100 = isDivisibleByFn(100);
    const by400 = isDivisibleByFn(400);
    let isLeapResult = Boolean(by4 && !by100);
    if (by400) {
      isLeapResult = true;
    }
    return isLeapResult;
  };
  ```
- If a student submits one-liner with a `return`, talk about implicit return of arrow functions with
  [concise body rather than block body](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions#Function_body).
