# Mentoring

## Reasonable solutions

```java
class Matrix {
    private int[][] matrix;

    Matrix(String matrixAsString) {
        matrix = matrixAsString.split("\n").stream()
            .map(
                row -> row.split(" ").stream()
                    .map(Integer::parseInt)
                    .toArray())
            .toArray(int[][]::new);
    }

    int[] getRow(int rowNumber) {
        // Use clone() to make a defensive copy
        return matrix[rowNumber - 1].clone();
    }

    int[] getColumn(int columnNumber) {
        return Arrays.stream(matrix).map(row -> row[column - 1]).toArray();
    }
}
```

## Common suggestions

- Initialize the matrix inside the constructor
- Use a data structure that represents the data stored (eg `int[][]` or `List<List<Integer>>`) rather than just storing
  exactly what was input to the constructor (eg Strings)
- Do not use mixed data structures (eg `List<int[]>`)
- Store the matrix exactly once (no `rows` with a transposed `columns`)
- Use the data structure to get the dimensions (length of the array or size of the List)

## Talking points

- Use defensive copying to protect against a rogue client:
```java
Matrix m = new Matrix("1 2 3\n4 5 6");
int[] row = m.getRow(1);
row[1] = -9; // Ah, they changed the `matrix`!
```
- Check for bad input:
  - A malformed matrix in the constructor (perhaps one that has a different number of columns in one or more of the rows).
  - A `rowNumber` outside of the bounds (either less than 1 or more than the number of rows)
  - A `columnNumber` outside of the bounds (either less than 1 or more than the number of columns)