# Mentoring

## Reasonable solutions

```javascript
const buildRow = (result, element, index, array) => {
  return [...result, element + (array[index + 1] || 0)];
}

export const rows = levels => {
  if (levels === 0)
    return [];

  const result = [[1]]
  for (let x = 1; x < levels; x++) {
    result.push(result[x - 1].reduce(buildRow, [1]));
  }
  return result;
}
```

```javascript
export const rows = size => {
  if (size === 0) {
    return [];
  }

  const result = [[1]];

  for (let y = 1; y < size; y++) {
    const lastRow = [];

    for (let x = 0; x <= y; x++) {
      const up = result[y - 1];
      const left = up[x - 1] || 0;
      const right = up[x] || 0;

      lastRow.push(left + right);
    }

    result.push(lastRow);
  }

  return result;
}
```
There are many valid ways implementing building the triangle, which all reduce
to the same and as long as the logic is sound, you should approve it.
