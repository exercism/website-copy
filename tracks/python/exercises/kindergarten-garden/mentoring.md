# Mentoring

## Reasonable solutions

```python
class Garden(object):

    DEFAULT_STUDENTS = [
        'Alice', 'Bob', 'Charlie', 'David',
        'Eve', 'Fred', 'Ginny', 'Harriet',
        'Ileana', 'Joseph', 'Kincaid', 'Larry',
    ]

    PLANT_NAMES = {
        'C' : 'Clover',
        'G' : 'Grass',
        'R' : 'Radishes',
        'V' : 'Violets'
    }

    def __init__(self, diagram, students=None):
        self.rows = diagram.splitlines()
        self.students = sorted(students if students is not None else self.DEFAULT_STUDENTS)
        self.student_index = {name:index for (index, name) in enumerate(self.students)}

    def plants(self, student):
        row_index = self.student_index[student] * 2
        letters = ''.join(row[row_index : row_index + 2] for row in self.rows)
        return [self.PLANT_NAMES[letter] for letter in letters]
```


## Common suggestions
- Use a constant list for default list of student names.
- Use a constant dict to map from letters to plant names, like `PLANT_NAMES` above.

## Talking points
- List comprehensions for lists of two things aren't that much shorter that just two copies of the code, but they work if the problem expands to more rows.
- Doing the whole computation in `plants()` means looking up the student in the least each time, which is O(n) for each query, and O(n^2) to ask about all students.
- To get O(n) constructor and O(1) lookup, you can either:
  - build a map of student numbers, as above, or
  - compute the whole answer for each student.
