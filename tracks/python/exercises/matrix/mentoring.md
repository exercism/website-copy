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
        self.rows = [
	    [int(s) for s in word.split()]
            for word in matrix_string.splitlines()
	]

    def row(self, index: int) -> list[int]:
        return self.rows[index - 1].copy()

    def column(self, index: int) -> list[int]:
        return [row[index - 1] for row in self.rows]
```

## Talking Points

### Delayed Construction

You will see solutions that store the matrix in 
an intermediate state, and then find the integers
when row() or column() are called. 
You will even find many solutions like this in the 
community area.

We should encourage students to move from strings to integers in `__init__`.
While there are no test cases with non-integers,
point out that if the input contained bad data,
you would want the constructor to fail, rather 
than failing at `row()` or `column()`.

### Duplicate Storage

You will see solutions that build two copies of 
the matrix: the original and the transposed matrix.
Point out that this takes twice the storage, and 
that constructing a column on the fly isn't that
difficult.

### String splitting choices

For the first `split()`, Python provides a handy `str.splitlines()` so an
explicit `str.split("\n")` isn't needed; Python can help figure out
line separators for you!

The `str.split()` function defaults to splitting on all whitespace. Since
we don't want whitespace in the entry we pass to `int()`, it's safe to assume
any whitespace in the data is a valid split point. If the student specifies
`str.split(" ")`, you can ask if the argument is needed.

#### Loop Choices

Often a student will build the list using an explicit list index, opting to
loop over `range(len(list))`. Point out that rarely is the index actually
what is needed in a loop. If they are using the index and the element, mention
the `enumerate()` built-in.

If the solution contains two loops, point out that iterating over the data
is expensive and why do it twice when it can be done just one time.

### To Copy or not to Copy

The solution presented copies the rows to avoid
any chance of updating the matrix. 
That may or may not be the model the programmer
has in mind: they may want to take a row and
update an entry.  

In any case, this isn't a topic to burden a beginner with, 
but can be a fun thing to point out once approving the exercise.
You can use something like:

```
Fun fact. If someone does: `matrix.row(3)[0] = 5`, this will alter the data
stored in the matrix. Conversely, if they did `matrix.column(3)[0] = 5`,
this would *not* update the matrix. Making `row()` behave like `column()`
is simple. The reverse is a fair bit more tricky. Something to think about :)
```
