The point of this exercise is to teach the student to use:
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo
- [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)

### Reasonable solutions

```javascript
export const isLeap = (year) => year % 4 === 0 && year % 100 !== 0 || year % 400 === 0;
```

```javascript
export const isLeap = (year) => !(year % 4) && year % 100 || !(year % 400);
```

### Common suggestions
- There are just two cases that return `true`:
  - A year is a multiple of 4 *and not* 100
  - A year is a multiple of 4, 100, and 400
- Order of operations matter:
  - 75% of all years *cannot* be leap years because they are not mulitples of 4; test `year % 4 === 0` first.
  - 98.97% of all years that are multiples of 4 are not multiples of 100; test `year % 100 !== 0` second.
  - 1.03% of all years that are multiples of 4 are also multiples of 100 and 400; test `year % 400 === 0` third.
- Eliminate duplicate work:
  -  Some submissions may repeat the same condition multiple times (`year % 4 === 0` is common); encourage students to resolve this by consolidating and/or reordering conditions.
- Submissions often explicitly return `true` or `false`; encourage the use of an implicit return.
- Submissions may include multiple `if/else` statements to satisfy the test suite; encourage users to consider how [logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators) can make their solution more concise.

### Talking points
- [`!`, `&&`, and `||`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [truthy](https://developer.mozilla.org/en-US/docs/Glossary/Truthy) and [falsy](https://developer.mozilla.org/en-US/docs/Glossary/Falsy) values in JavaScript
- Differences between loose value equality (`==`) and same-value equality (`===`)
