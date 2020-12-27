This exercise builds upon their knowledge of arrays from the previous exercise `resistor-color`. It's a natural
extension and prepares them for `resistor-color-trio`.

### Reasonable solutions

```javascript
// NOTE: this is the solution to resistor-color, see notes below
const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet',
  'grey', 'white',
];

const colorCode = (color) => COLORS.indexOf(color)
// END OF NOTE

export function decodedValue([tens, ones]) {
  return colorCode(tens) * 10 + colorCode(ones)
}
```

A student may choose to use numeric indexing instead of destructuring:

```javascript
export function decodedValue(colors) {
  return colorCode(colors[0]) * 10 + colorCode(colors[1])
}
```

A student may also use an arrow function expression instead of a function declaration, as well as using an implicit
return instead of an explicit `return`.

#### Previous versions

Previously, it was possible to use `.map` or `.reduce` on the input and map/reduce over all values, but an extra test
has been added that breaks these solutions. Solutions using `map` and `reduce` are still fine, but need to be
prepended by a `slice` or `splice` to only get the first two values.

#### Importing `resistor-color`

A student _may_ import their `colorCode` function from `../resistor-color/resistor-color`. This is perfectly fine and
should be regarded as such. **DO NOT** suggest them to add this import if they don't have it.

#### Approvability

The solution listed above as well as any of the solutions that divert from this listed directly below are
approvable. Anything listed under **Common Suggestions** is _not_.

A student who uses a `reducer` on the `reverse` of the input. The solution below is such a solution. It's overly
complex for the task at hand. You may approve it, but mentor them in order to simplify the solution.

```javascript
export const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet',
  'grey', 'white',
];

export function decodedValue(colors) {
  return colors
    .reverse()
    .slice(0, 2)
    .reduce(
      (value, color, i) => {
        // Find the index, then shift it in base 10, i places to the left
        return colorCode(color) * (10 ** i) + value
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

export function decodedValue(colors) {
  return Number(`${colorCode(colors[0])}${colorCode(colors[1])}`)
}
```

But this type juggling is unnecessary. Approve it, but recommend them to use math instead:

```javascript
export const decodedValue = (bands) => colorCode(bands[0]) * 10 + colorCode(bands[1])
```

### Common suggestions

Here are a few common suggestions based on student's solutions. You may always suggest they re-use code from
their solution to `resistor-color`. The gist of the suggestions follows now, after which each one is
elaborated on.

#### `parseXXX` family

If a student is using `parseFloat` or `parseInt` to convert back to a number, introduce them to [`Number(...)`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number#Using_Number_to_convert_a_Date_object).
The `parseXXX` family is _great_ if you do not know if the input is a number, but when you know it, it's better to use
the stricter `Number(...)` function.

```javascript
// BAD example
export function decodedValue(colors) {
  return parseInt(
    colors.slice(0, 2)
          .map(color => colorCode(color))
          .join('')
  )
}
```

This is a good first step before you show them that they _don't need to convert at all_ using math.

#### `reduce` the array to a string

If a student is using `map` followed by a `reduce` to build the string of digits, introduce them to [`Array#join`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join).

```javascript
// BAD example
export function decodedValue(colors) {
  return Number(
    colors.slice(0, 2)
          .map(color => colorCode(color).toString())
          .reduce((r, s) => r + s)
  )
}
```

Then, let them know they don't need to convert at all. Help them discover the solution using just numbers and math.

#### Explicit string conversions

If a student is converting each `indexOf` to a string, (`+ ""` or `.toString()`), they probably didn't need that as
[`Array#join`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join) does that
for you.

```javascript
// BAD example
export function decodedValue(colors) {
  return Number(
    colors.slice(0, 2)
          .map(color => colorCode(color).toString())
          .join('')
  )
}
```

But, they don't need to convert at all. Help them discover the solution using just numbers and math.

#### Not using `colorCode`

Some students may "re-discover" the implementation of `resistor-color`:

```js
const COLORS = [ ... ]

export function decodedValue(colors) {
  return COLORS.indexOf(colors[0]) * 10 + COLORS.indexOf(colors[1])
}
```

This is _not_ approvable. There is a reason they had to do `resistor-color` first. Mentor them so they'll re-use that
solution (e.g. copy the `colorCode` function, or `import` it). In `resistor-color-trio` these concepts are visited
again, and it helps if they don't have to start anew.


