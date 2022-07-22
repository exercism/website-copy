# Mentoring

## Problem and challenges

This problem requires the student to find the points in a matrix (represented as `list[list[int]]`) that are both the highest value in that row and the lowest value in that column.

## Reasonable solution

```python
def saddle_points(matrix):
    result = []
    if not matrix:
        return result
    if not all(len(row) == len(matrix[0]) for row in matrix):
        raise ValueError("irregular matrix")
    for row_num, row in enumerate(matrix):
        for column_num in range(len(row)):
            if max(row) == min(row[column_num] for row in matrix):
                result.append({"row": row_num + 1, "column": column_num + 1})
    return result
```

## Common suggestions

### Checking for an empty or invalid matrix

This problem requires identifying when the matrix is irregular i.e. the number of items in each row is inconsistent. 
The easiest way to do this is to simply check that the length of each row is equal to the length of the first row. 
Students may also include additional checks for other types of invalid data if desired.

It is also helpful to first identify when an empty matrix has been given and return an empty result. 
This prevents an `IndexError` from trying to index into an empty list.

```python
# Best solution2
if not matrix:
    return []
if not all(len(row) == len(matrix[0]) for row in matrix):
    raise ValueError("irregular matrix")```
# or:
if any(len(row) != len(matrix[0]) for row in matrix):
    raise ValueError("irregular matrix")```

        
# Acceptable solution
if len(matrix) == 0:
  return []
row_length = len(matrix[0])
for row in matrix:
  if len(row) != row_length:
    raise ValueError("irregular matrix")
 ```

This might be a good place to introduce concepts like list comprehensions and the `all()` or `any()` functions, which are easier to use here but will be helpful for the main problem.

### Iterating over the values

There are various ways of iterating over the values, but nested `for` loops are the most straightforward. 
Since the column and row indices are required along with the values, this is a good place to introduce the `enumerate()` function. 
This should be preferred over using a combination of `range()` and `len()`.

```python
for row_num, row in enumerate(matrix):
    for column_num in range(len(row)):
```

### Checking for saddle points

Students must check that the value is the highest value in that row and the lowest value in the column. 
This is a good place to introduce the `max()` and `min()` functions which take an iterable and return the highest or lowest value.

Another challenge here is getting the column. 
At this stage most students should be ready to use a comprehension which is the best way, but students who aren't familar with comprehensions might use an additional `for` loop instead. 
To make it simpler, suggest creating a separate function for getting the column. 

Students will often write more complicated checks than required. 
Once we've extracted the row and column that we want to check, all we need to do is check that the `max` of the row is equal to the `min` of the column. 
Guide them to think about what we're checking for and suggest that they experiment with different checks to see what works.

```
# Suggested solution
if max(row) == min(row[column_num] for row in matrix):

# Alternative solution:
def get_column(matrix, col_index):
  return row[col_index] for row in matrix
if max(row) == min(get_column(matrix, col_index):
```

### Returning the result

The task requires returning a `list` of `dict` objects, one for each saddle point, with the keys "row" and "column" and the values being the one-based index (i.e. the location, not the value, of the saddle points).

```
result.append({"row": row_num + 1, "column": column_num + 1})
    return result
```

## Talking points

This problem potentially introduces several new concepts to the student, including:
- inner loops
- list comprehensions
- the built-in functions `all`, `max`, `min` and `enumerate`

If the student wants to explore alternative approaches, one approach is to create a transverse matrix for easier access to the columns:

for row_num, row in enumerate(matrix):
    for col_num, col in enumerate(zip(*matrix)):
        if max(row) == min(col):
# alternatively:
transverse_matrix = [
  [row[col_num] for row in matrix] 
  for col_num in range(len(matrix[0]))
]
```
