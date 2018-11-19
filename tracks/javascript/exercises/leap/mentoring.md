The point of this exercise is to teach the student to use:
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo
- [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)

## Reasonable Solutions

```javascript
export const isLeap = year => year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0);
```
Inverse tests:
```javascript
export const isLeap = year => year % 400 === 0 || (year % 4 === 0 && year % 100 !== 0);
```


## Common suggestions
- There are two types of students that give different responses than the reasonable solutions:
  - A student explicitly returns `true` and `false` and doesn't use [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators) to combine multiple expressions,
  - A student comes up with something "clever", that is usually either unreadable at first sight or unmaintable, or both.

- `eslint` will warn when mixing `&&` and `||`, adding parentheses here is recommended to increase readability:
  - _order of operation_ matters:
    - 75% of all years *cannot* be leap years because they are not multiples of 4; test `year % 4 === 0` first
    - 98.97% of all years that are multiples of 4 are not multiples of 100; test `year % 100 !== 0` second
    - 1.03% of all years that are multiples of 4 are also multiples of 100 and 400; test `year % 400 === 0` third
  - _order of evaluation_ matters: Refer to [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence). In Javascript `&&` always goes before `||`. Adding parentheses clears up any confusion, and groups the second and third test together.
- There are only two cases that return true:
  - a year MUST be a multiple of four AND NOT be a multiple of 100
  - a year MUST be a multiple of 400 (implies multiple of 4 and 100)
- Eliminate duplicate work; no year should ever have to be checked multiple times for the same condition.

## Talking points
* [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo. This usually does not need explaining.
* [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators), especially `&&` and `||`. If they use the binary forms, explain how [short-circuit](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators#Short-circuit_evaluation) evaluation works.
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence): unlike other languages, logical AND (`&&`) _always_ has a **higher** precedence than logical OR (`||`).
* Logical operators `&&` `||` are more idiomatic than `if ... return ...`.
- Maintainability and performance:
  Something like this ís readable and maintainable, but if a student submits this, point out resources (functions are created each invocation) and returning expression evaluations:

  ```javascript
  function isDivisibleBy(number) {
    return mod => number % mod === 0;
  }

  export const isLeap = year => {
    const isDivisibleByFn = isDivisibleBy(year);
    const by4 = isDivisibleByFn(4);
    const by10 = isDivisibleByFn(10);
    const by400 = isDivisibleByFn(400);
    let isLeapResult = Boolean(by4 && !by10);
    if (by400) {
      isLeapResult = true;
    }
    return isLeapResult;
  };
  ```

  In this example, each invocation `isDivisibleFn` is recreated, which can be fixed by inversing the curry; and all values are calculated before they are used. In fact, when `by400` is true, the rest doesn't matter, so it's a waste of CPU cycles. This solution can still be used but changed to fix all these issues:

  ```javascript
  function isDivisibleByFn(mod) {
    return number => number % mod === 0;
  }

  const by4 = isDivisibleByFn(4);
  const by10 = isDivisibleByFn(10);
  const by400 = isDivisibleByFn(400);

  export const isLeap = year => by400(year) || (by4(year) && !by10(year))
  ```
