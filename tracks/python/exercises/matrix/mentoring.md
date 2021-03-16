# Mentoring

## Problem and Challenges

The problem asks you to write a Matrix class.
The constructor takes as input a string holding 
lines of integers. The problem asks you
to write methods row() and column().

## Reasonable Solution

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

## Talking Points

### Delayed Construction

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

### Duplicate Storage

You will see solutions that build two copies of 
the matrix: the original and the transposed matrix.
Point out that this takes twice the storage, and 
that constructing a column on the fly isn't that
difficult.

### To Copy or not to Copy

The solution presented copies the rows to avoid
any chance of updating the matrix. 
That may or may not be the model the programmer
has in mind: they may want to take a row and
update an entry.  

In any case, this isn't a topic to burden a beginner with, 
but you may want to comment about it if you see it in the solution. 
