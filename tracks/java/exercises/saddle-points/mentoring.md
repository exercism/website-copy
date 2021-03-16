# Mentoring

## Reasonable solutions

**Checking if each point is a Saddle Point**

This is probably the simplest solution and keeps things pretty straightforward.

```java
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

final class Matrix {

    private final List<List<Integer>> values;

    Matrix(List<List<Integer>> values) {
        this.values = values;
    }

    Set<MatrixCoordinate> getSaddlePoints() {
        Set<MatrixCoordinate> result = new HashSet<>();

        if (values.isEmpty()) {
            return result;
        }

        for (int row = 0; row < values.size(); row++) {
            for (int column = 0; column < values.get(0).size(); column++) {
                int coordinateValue = values.get(row).get(column);

                if (coordinateValue == getRowMax(row)
                    && coordinateValue == getColumnMin(column)) {
                    result.add(new MatrixCoordinate(row + 1, column + 1));
                }
            }
        }

        return result;
    }

    private int getRowMax(int row) {
        return Collections.max(values.get(row));
    }

    private int getColumnMin(int column) {
        return values.stream()
            .map(row -> row.get(column))
            .min(Integer::compareTo)
            .orElseThrow(() -> new IllegalArgumentException("Column cannot be empty"));
    }
}
```

**Finding the row mins and column maxes first**

Rather than checking the whole row and column for every coordinate to check if
each point is a Saddle Point, we can pre-process the matrix and find all of the
column minimums and row maxes. This reduces the number of extra times that each
row and column has to be traversed (requiring exactly 3 traversals):

```java
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

final class Matrix {

    private final List<List<Integer>> values;
    private final List<Integer> maxPerRow;
    private final List<Integer> minPerColumn;
    
    Matrix(List<List<Integer>> values) {
        this.values = values;
        this.maxPerRow = getMaxPerRow(values);
        this.minPerColumn = getMinPerColumn(values);
    }
    
    private static List<Integer> getMaxPerRow(List<List<Integer>> values) {
        List<Integer> maxes = new ArrayList();
        for (List<Integer> row : values) {
            maxes.add(Collections.max(row));
        }
        return maxes;
    }
    
    private static List<Integer> getMinPerColumn(List<List<Integer>> values) {
        List<Integer> mins = new ArrayList();
        if (values.isEmpty()) {
            return mins;
        }
    
        for (int i = 0; i < values.get(0).size(); i++) {
            mins.add(getColumnMin(values, i));
        }
        return mins;
    }
    
    private static Integer getColumnMin(List<List<Integer>> values, int column) {
        return
            values.stream()
                .map(row -> row.get(column))
                .min(Integer::compareTo)
                .orElseThrow(() -> new IllegalArgumentException("Column cannot be empty"));
    }
    
    Set<MatrixCoordinate> getSaddlePounts() {
    
        Set<MatrixCoordinate> result = new HashSet<>();
        
        if (values.isEmpty()) {
            return result;
        }
        
        for (int row = 0; row < values.size(); row++) {
            for (int column = 0; column < values.get(0).size(); column++) {
                int coordinateValue = values.get(row).get(column);
        
                if (coordinateValue == maxPerRow.get(row)
                    && coordinateValue == minPerColumn(column)) {
                    result.add(new MatrixCoordinate(row + 1, column + 1));
                }
            }
        }
        
        return result;
    }
}
```

**Set intersection**

Finding all of the mins and maxes as before, but tracking the specific points
where they were and then taking the intersection of the two sets of points.

```java
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import java.util.stream.Collectors;

final class Matrix {

    private final List<List<Integer>> values;
    private final Set<MatrixCoordinate> maxPerRow;
    private final Set<MatrixCoordinate> minPerColumn;
    
    Matrix(List<List<Integer>> values) {
        this.values = values;
        this.maxPerRow = getMaxPerRow(values);
        this.minPerColumn = getMinPerColumn(values);
    }
    
    private static Set<MatrixCoordinate> getMaxPerRow(List<List<Integer>> values) {
        Set<MatrixCoordinate> maxes = new HashSet();
        for (int row = 0; row < row.size(); row++) {
            int max = Collections.max(values.get(row));
            for (int col = 0; col < values.get(row).size(); col++) {
                if (values.get(row).get(col) == max) {
                    maxes.add(new MatrixCoordinate(row + 1, col + 1));
                }
            }
        }
        return maxes;
    }
    
    private static Set<MatrixCoordinate> getMinPerColumn(List<List<Integer>> values) {
        Set<MatrixCoordinate> mins = new HashSet();
        if (values.isEmpty()) {
            return mins;
        }
    
        for (int col = 0; col < values.get(0).size(); col++) {
            int min = getColumnMin(values, col);
            for (int row = 0; row < values.size(); row++) {
                if (values.get(row).get(col) == min) {
                    mins.add(new MatrixCoordinate(row + 1, col + 1));
                }
            }
        }
        return mins;
    }
    
    private static int getColumnMin(List<List<Integer>> values, int column) {
        return
            values.stream()
                .map(row -> row.get(column))
                .min(Integer::compareTo)
                .orElseThrow(() -> new IllegalArgumentException("Column cannot be empty"));
    }
    
    Set<MatrixCoordinate> getSaddlePounts() {

        if (values.isEmpty()) {
            return new HashSet<>();
        }
        
        return maxPerRow.stream().filter(minPerColumn::contains).collect(Collectors.toSet());
    }
}
```