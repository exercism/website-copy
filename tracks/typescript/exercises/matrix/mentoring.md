# Mentoring

This exercise introduces:
- String reader via [`String#split`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String/split)
- [`Array#map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)

## Reasonable solutions

There are two ways to transpose the matrix. Either non-destructive:

```typescript
function transpose<T>(rows: Readonly<T[][]>): T[][] {
  return rows[0].map((_, i) => {
    return rows.map((row) => {
        return row[i]
    })
  })
}
```

Or destructive:

```typescript
function transpose<T>(matrix: T[][]): T[][] {
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

```typescript
class Matrix {

  public readonly rows: number[][]
  public readonly columns: number[][]

  constructor(input: Readonly<string>) {
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
- If a student uses `map(arg => Number(arg))`, explain they can drop the anonymous arrow function and pass in `Number` directly.
- If a student uses `any[][]`, point them towards `name<T>(arg: Readonly<T[][]>): T[][]` which preserves the type of the arrays
- If a student builds both array in one go, as shown below this suggestion, suggest `Array#map` and point them to "transpose algorithm":

```javascript
const rows: number[][] = []
const columns: number[][] = []

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

## Talking points
- Functions are first class citizens, so you can pass one to `Array#map` and it executes on each one
- Immutability and side effects
