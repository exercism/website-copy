### Reasonable solutions

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

    def __init__(self, diagram, students=DEFAULT_STUDENTS):
        self.rows = diagram.split('\n')
        self.students = sorted(students)

    def plants(self, student):
        student_index = self.students.index(student)
        row_index = student_index * 2
        letters = ''.join(row[row_index : row_index + 2] for row in self.rows)
        return [self.PLANT_NAMES[letter] for letter in letters]
```


### Common suggestions
- Using a constant dict to map from letters to plant names, like `PLANT_NAMES` above.

### Talking points
- List comprehensions for lists of two things aren't that much shorter that just two copies of the code, but they work if the problem expands to more rows.
- You can build the assignments of plants to students once, in the constructor, on on-demand in the `plants()` method.
