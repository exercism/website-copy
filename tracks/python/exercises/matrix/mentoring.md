### Problem and Challenges

The problem asks you to write a Matrix class.
The constructor takes as input a string holding 
lines of integers. The problem asks you
to write methods row() and column().

### Reasonable Solution

```python
class Matrix(object):

    def __init__(self, matrix_string: str):
        self.rows = [[int(s) for s in word.split()]
                     for word in matrix_string.split('\n')]

    def row(self, index: int) -> list:
        return self.rows[index - 1].copy()

    def column(self, index: int) -> list:
        return [row[index - 1] for row in self.rows]
```

### Talking Points

#### Delayed Construction

You will see solutions that store the matrix in 
an intermediate state, and then find the integers
when row() or column() are called. 
You will even find many solutions like this in the 
community area.

We should encourage students to move from strings to integers in __init__. 
While there are no test cases with non-integers,
point out that if the input contained bad data,
you would want the constructor to fail, rather 
than failing at row() or column()

#### Duplicate Storage

You will see solutions that build two copies of 
the matrix: the original and the transposed matrix.
Point out that this takes twice the storage, and 
that constructing a column on the fly isn't that
difficult.

#### To Copy or not to Copy

The solution presented copies the rows to avoid
any chance of updating the matrix. 
That may or may not be the model the programmer
has in mind: they may want to take a row and
update an entry.  

In any case, this isn't a topic to burden a beginner with, 
but you may want to comment about it if you see it in the solution. 

### Separation of Concerns

You will see solutions where the student has split `matrix_string` in the constructor, then done the actual construction of the matrix in the getters.

```
class Matrix:
    def __init__(self, matrix_string):
        self.matrix = matrix_string.split('\n')

    def row(self, index):
        return list(map(int, self.matrix[index - 1].split(' ')))

    def column(self, index):
        column = []
        for row in self.matrix:
            column.append(int(row.split(' ')[index - 1]))
        return column
```

You should explain SoC to your student, and ask them to submit another iteration where the getters (`row`, `column`) do their one job - interrogate the matrix in `self` for the data requested.

There's a bit of ambiguity as to whether the constructor should also construct the matrix in such a way that `column` can be retrived with something like `return self.columns[index - 1]`. It's probably not important enough to decline approval if they've taken that route, although I'd ask where that ends. If we want to retrieve the top-left value, or the bottom right, do we write another constructor line to store that in `self`? I'd argue not, but it's fairly subjective.
