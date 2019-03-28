This exercise introduces `map` and `join` to the student, as well as converting from and to `number`, and builds upon
their knowledge of arrays from the previous exercise `resistor-color`.

### Reasonable solutions

```javascript
export const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet',
  'grey', 'white',
];

export function value(colors) {
  return Number(colors.map(color => COLORS.indexOf(color)).join(''))
}
```

A student may choose to enter the `function` into `map`:

```javascript
colors.map(COLORS.indexOf.bind(COLORS))
```

A student may use also use an arrow function expression instead of a function declaration, as well as using an
implicit return instead of an explicit `return`.

#### Approvability

The solution listed above as well as any of the solutions that divert from this listed directly below are
approvable. Anything listed under **Common Suggesstions** is _not_.

A student who uses a `reducer` on the `reverse` of the input. This is a technique that comes from other languages
as well as algorithm solving in university and is perfectly valid. It's one of the ways to do this without 
conversion to a `String`. Such a solution looks like this:

```javascript
export const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet',
  'grey', 'white',
];

export function value(colors) {
  return colors
    .reverse()
    .reduce(
      (value, color, i) => {
        // Find the index, then shift it in base 10, i places to the left
        return COLORS.indexOf(color) * (10 ** i) + value
      }
      , 0
    );
}
```

A variation is not using `reverse` but instead using `length - i`. Or using `reduceRight` without `reverse`.

The second exception is using string interpolation to build the value, or manually extracting the two colors. 
This is technically correct, because **only the first two color bands** can be calculated using the method in
this exercise. It looks something like this:

```javascript
export const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet',
  'grey', 'white',
];

export function value(colors) {
  return Number(`${COLORS.indexOf(colors[0])}${COLORS.indexOf(colors[1])}`)
}
```

Or this:

```javascript
export const value = bands => colorCode(bands[0]) * 10 + colorCode(bands[1])
```

Approve the solution, but challenge them to solve it using `map`, as listed below.

### Common suggestions

Here are a few common suggestions based on student's solutions. You may always suggest they re-use code from their
solution to `resistor-color`. The gist of the suggestions follows now, after which each one is elaborated on.

- `Number` instead of `parseXXX`
- `join` instead of `reduce`
- `join` (converts to string) instead of explicit `toString`
- `Array` for `COLORS` instead of `Object`

#### `parseXXX` family

If a student is using `parseFloat` or `parseInt` to convert back to a number, introduce them to [`Number(...)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object).
The `parseXXX` family is _great_ if you do not know if the input is a number, but when you know it, it's better to use
the stricter `Number(...)` function.

```javascript
// BAD example
export function value(colors) {
  return parseInt(colors.map(color => COLORS.indexOf(color)).join(''))
}
```

#### `reduce` the array to a string

If a student is using `map` followed by a `reduce` to build the string of digits, introduce them to [`Array#join`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join).

```javascript
// BAD example
export function value(colors) {
  return Number(
    colors.map(color => COLORS.indexOf(color).toString())
          .reduce((r, s) => r + s)
  )
}
```
#### Explicit string conversions

If a student is converting each `indexOf` to a string, (`+ ""` or `.toString()`), they probably didn't need that as
[`Array#join`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join) does that
for you.

```javascript
// BAD example
export function value(colors) {
  return Number(colors.map(color => COLORS.indexOf(color).toString()).join(''))
}
```
#### Using an `Object` with index values

If a student uses an object where each key is a color and each value is the index it would have if it were a list, they
might not have linked this exercise to the previous one called `resistor-color`. That said, explain they should use
`indexOf` and an `Array` when an `Object` looks like this.

