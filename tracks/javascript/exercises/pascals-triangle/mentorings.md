### Reasonable solutions

```javascript
function buildRow(result, element, index, array) {
  return result.concat([element + (array[index + 1] || 0)])
}

function makeTriangle(levels) {
  const result = [[1]]
  for (let x = 1; x < levels; x += 1) {
    result.push(result[x - 1].reduce(buildRow, [1]))
  }
  return result
}

export class Triangle {
  constructor(levels) {
    this.rows = makeTriangle(levels)
  }

  get lastRow() {
    return this.rows[this.rows.length - 1]
  }
}
```

```javascript
export class Triangle {
    constructor(size) {
        this.rows = [[1]]

        for (let y = 1; y < size; y++) {
            this.lastRow = []

            for (let x = 0; x <= y; x++) {
                const up = this.rows[y - 1]
                const left = up[x - 1] || 0
                const right = up[x] || 0

                this.lastRow.push(left + right)
            }
            this.rows.push(this.lastRow)
        }
    }
}
```
There are many valid ways implementing building the triangle, which all reduce
to the same and as long as the logic is sound, you should approve it.
