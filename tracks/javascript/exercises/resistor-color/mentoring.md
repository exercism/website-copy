# Mentoring

This exercise introduces the student to [`Arrays`][ref-array] as well as showing that you can export multiple bindings
at once.

## Reasonable solutions

```javascript
export const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet',
  'grey', 'white',
];

export const colorCode = (color) => COLORS.indexOf(color)
```

A student may use a function declaration instead of an arrow function expression, as well as using an explicit `return`
instead of an implict return.

```javascript
const COLORS_MAP = {
  'black': 0,
  'brown': 1,
  'red': 2,
  'orange': 3,
  'yellow': 4,
  'green': 5,
  'blue': 6,
  'violet': 7,
  'grey': 8,
  'white': 9
}

export const COLORS = Object.keys(COLORS_MAP)

export const colorCode = (color) => COLORS_MAP[color];
```

This early in the track, we do not care about the data-structure. Do not comment on the usage of an `Object` instead of
an `Array`. However, check the common suggestions for anything else. A `Map` is considered the same as using an
`Object`, in this particular instance.


## Common suggestions

If the solution does not look like the reasonable solution, do _not_ approve it. Here are a few common suggestions
based on student's solutions.

### Manually doing `indexOf`

A student may manually try to find the index of a color:

```javascript
export function colorCode(color) {
  let index = -1
  for (let i = 0; i < COLORS.length; i++) {
    if (COLORS[i] === color) {
      index = i
      // if they return _here_ it would be indexOf. If they don't like in this
      // example, it's actually lastIndexOf.
    }
  }

  return i
}
```

### Using `findIndex`

A student may try using [`Array#findIndex`][ref-array-find-index] for the `colorCode()` method but remind them that
[`Array#indexOf`][ref-array-index-of] only requires a simple string as the argument whereas
[`Array#findIndex`][ref-array-find-index] requires a function to determine the index.

```js
export const colorCode = (color) => COLORS.findIndex(currentColor => currentColor === color);

// vs

export const colorCode = (color) => COLORS.indexOf(color);
```

Introduce the student to [`Array#indexOf`][ref-array-index-of].

### A set of conditionals or a switch

A student may use a series of ifs or a `switch` statement:

```javascript
export function colorCode(color) {
  let code = -1

  if (color === 'black') {
    code = 0
  } else if (color === 'brown') {
    code = 1
  } else if (color === 'red') {
    // ... etc
  }

  return code
}
```

They may not know of the _concept_ of `Array`. You may gently ask how experienced they are with programming. **Note**
that there _are_ languages that do **not** have arrays. So them not knowing about it does not mean they don't have any
experience.

### Using an Object/Map but not indexer/Keys

If a student uses an `Object` to store the data, the valid way to export the `COLORS` constant is by using
`Object.keys`. If they are manually mapping for the object, you should indicate that manual mapping is not necessary
and if they need the extra help, point them towards `Object.keys`.

Similarly, if they use an `Object`, they _SHOULD_ use the indexer (`[index]` bracket notation).

### Time Complexity

A student may use an `Object` instead of an `Array` to store color names with the intention to optimize the execution
time.

**Only if the student asks** discuss the time-complexity. This is _too_ early in the track to think about these
concepts. This is **not** cause for disaproval. If, and only if, the discussion gets here, you can check (and share)
the performance on both solutions following this [jsPerf][benchmark]. The performance is barely different (~4%) for
the size of data on this exercise.

You should ask the student to justify their decision; these are some discussion points you can use:

* O(N) for small numbers doesn't matter at all, in terms of execution speed.
* Solutions with hash tables instead simple arrays comes with additional costs: Maintenance and increased complexity.
* Learn about the value of writting code *in context*, in other words, **not** to over engineer to soon.
* The exercise is **intentionally** easy and straighforward.

The solution proposed by the student could following these lines:

```javascript
const colorsCode = {
  'black': 0,
  'brown': 1,
  'red': 2,
  'orange': 3,
  'yellow': 4,
  'green': 5,
  'blue': 6,
  'violet': 7,
  'grey': 8,
  'white': 9
}

export const COLORS = Object.keys(colorsCode)

export function colorCode(color) {
  return colorsCode[color]
}
```

[ref-array]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array
[ref-array-index-of]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf
[ref-array-find-index]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/findIndex
[benchmark]: https://jsperf.com/resistor-color-perf
