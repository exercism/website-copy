# Mentoring

## Reasonable solutions
```typescript
export default class Triangle {

  public readonly rows: number[][]

  constructor(levels: number) {
    this.rows = this.makeTriangle(levels)
  }

  get lastRow() {
    return this.rows[this.rows.length - 1]
  }

  private buildRow(result: number[], element: number, index: number, array: number[]) {
    return result.concat([element + (array[index + 1] || 0)])
  }

  private makeTriangle(levels: number) {
    const result = [[1]]
    for (let x = 1; x < levels; x += 1) {
      result.push(result[x - 1].reduce(this.buildRow, [1]))
    }
    return result
  }
}
```

`makeTriangle` can be implemented many different ways, and as long as the logic
is sound, you should approve it. Alternatives use `zip` (which is what
`buildRow` does by "zipping" self + neighbor), recursion, or one single `for`
loop.

## Common suggestions
- `rows` should be `readonly` (and students should now that by now)
- a getter makes more sense than an extra field `lastRow`
