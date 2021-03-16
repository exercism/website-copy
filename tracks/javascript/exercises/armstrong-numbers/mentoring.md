# Mentoring

## Reasonable solution

The solution should consist of the following three steps:

1. convert the input `number` to a list of digits
2. `reduce` the list of digits to a _sum_ of each digit to the power of the number of digits
3. compare the input to the summation

```javascript
export function steps(input) {
  const digits = [...input.toString(10)].map(Number)
  const n = digits.length
  return input === digits.reduce((result, digit) => result + digit ** n, 0)
}
```

### Converting to a list of digits

Most approaches of converting a `number` to a list of digits is to first
convert said `number` to a `string` and splitting on each character boundary.

To accomplish this, idiomatically the student can use `.toString(10)` to be
very explicit about the conversion or use `String(input)` and rely on the
default behaviour. Splitting the string per character can be done using the
`string` descructuring `[...string]` or `.split('')`. Since we're only dealing
with numbers, both are equally fine.

The final result, depending on the rest of the code, does **not** need to be
converted back to an `array` of numbers, but it's probably _cleaner_ to do so.

### Summation of powers

The general way to sum a list in JavaScript is to use `.reduce`. Approaches
using `for(...)` loops are possible, but not as idiomatic as possible. In order
to get the sum of each digit's power, each iteration should take the current
accumulation and add `Math.pow(digit, length)`. Both the usage of `Math.pow`
and its equivalent operator `**` are idiomatic.

It's cleaner to extract out the length _before_ iteration, but its also fine
to rely on the engine to optimise it. The length can either be extracted from
the `digits` array, or from `self`, the fourth argument of the `.reduce(...)`
callback.

### Common suggestions

- Its more idiomatic to explicitly convert to a string, instead of using `+ ''`
- Instead of using `.map(n => +n)`, the `Number` function can be passed in,
  without an anonymous function: `.map(Number)`.
- Bookkeeping variables such as `result` are unnecessary. Suggest `.reduce`.
