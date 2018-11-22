The point of this exercise is to teach the student to use:
- [Remainder (%)](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Arithmetic_Operators#Remainder_()), also known as modulo
- [Logical operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [Operator precedence](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Operator_Precedence)

### Reasonable solutions

```javascript
export const isLeap = (year) => year % 4 === 0 && (year % 100 !== 0 || year % 400 === 0);
```
Variations check for truthy `year % m` and falsy `(!year % m)`.

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
- Eliminate duplicate work: no year should ever have to be checked multiple times for the same condition; encourage students to resolve this by consolidating and/or reordering conditions.

### Talking points
- [`!`, `&&`, and `||`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Logical_Operators)
- [truthy](https://developer.mozilla.org/en-US/docs/Glossary/Truthy) and [falsy](https://developer.mozilla.org/en-US/docs/Glossary/Falsy) values in JavaScript
- Differences between loose value equality (`==`) and same-value equality (`===`)
