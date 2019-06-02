This exercise introduces the student to [`Arrays`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array) as well as showing that you
can export multiple bindings at once.

### Reasonable solutions

```javascript
export const COLORS = [
  'black', 'brown', 'red', 'orange', 'yellow', 'green', 'blue', 'violet',
  'grey', 'white',
];

export const colorCode = color => COLORS.indexOf(color)
```

A student may use a function declaration instead of an arrow function expression, as well as using an explicit `return`
instead of an implict return.

### Common suggestions

If the solution does not look like the reasonable solution, do _not_ approve it. Here are a few common suggestions based
on student's solutions.

#### Manualy doing `indexOf`

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

Introduce the student to [`Array#indexOf`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/indexOf).

#### A set of conditionals or a switch

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

#### Time Complexity

A student may use an `Object` instead of an `Array` to store color names with the intention to optimize the execution time.
This is **not** cause for disaproval but it's a good opportunity to discuss with the student about not to prematurely optimize code.

You can check (and share) the performance on both solutions following this [jsPerf](https://jsperf.com/resistor-color-perf). The performance is barely different (~4%) for the size of data on this exercise.

You should ask the student to justify and discuss their decision; make them aware that the exercise is intentionally easy and straighforward. Also make sure they see the value of writting code *in context*, in other words, **not** to over engineer

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
