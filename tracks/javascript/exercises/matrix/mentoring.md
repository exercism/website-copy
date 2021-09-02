# Mentoring

This exercise introduces:
- String reader via [`String#split`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split)
- [`Array#map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)

## Reasonable solutions

There are two ways to transpose the matrix. Either non-destructive:

```javascript
function transpose(rows) {
  return rows[0].map((_, i) => {
    return rows.map((row) => {
        return row[i]
    })
  })
}
```

Or destructive:

```javascript
function transpose(matrix) {
  for (let i = 0; i < matrix.length; i++) {
    for (let j = 0; j < i; j++) {
      [matrix[i][j], matrix[j][i]] = [matrix[j][i], matrix[i][j]]
    }
  }
  return matrix
}
```

In case of the latter, the logic becomes harder. Make sure the implementation of
the student allows for calling both `columns` and `rows` on the same instance,
multiple times. This is _not_ part of the test suite (yet). This is important if
the student uses getters for example.

The matrix itself is straight-forward:

```javascript
export class Matrix {
  constructor(input) {
    this.rows = input.split('\n').map((row) => row.split(' ').map(Number))
    this.columns = transpose(this.rows)
  }
}
```

A student may use `parseInt` instead of `number`, and a student may use getters
(`get rows() { return this.data }`) to make the transposing lazy.

## Common suggestions
- If a student uses `foreach`, intermediary bookkeeping and `push`, suggest [`Array#map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map).
- If a student uses a dangerous version of transpose, suggest a non-destructive one, or make sure it's only ever called once.
- If a student uses `map(arg => parseInt(arg))` or similar, explain they can drop the anonymous arrow function and pass in `Number` function directly, but not `parseInt` because that accepts two arguments and `Array#map` passes item index implicitly.
- If a student builds both array in one go, as shown below this suggestion, suggest `Array#map` and point them to "transpose algorithm":

```javascript
const rows = []
const columns = []

input.split('\n')
  .forEach((row, i) => {
    this.rows.push(row.split(' ').map(Number))
    this.rows[i].forEach(
      i === 0
        ? (e) => this.columns.push([e])
        : (e, j) => this.columns[j].push((e))
    )
  })
```
 -If a student try to do everything inside the constructor suggest on them to defer calculations to getters as they are supposed to defer the cost of calculating the value until it is needed. If the value never needed, you never pay the cost.[[2](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/get)] 

## Talking points
- Functions are first class citizens, so you can pass one to `Array#map` and it executes on each one
- Immutability and side effects
