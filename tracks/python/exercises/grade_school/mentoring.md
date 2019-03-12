### Problem and challenges

The challenge is to implement a Class representing students in a school. 
Each student has a unique first name and a grade. 
We need to implement a method to add a student to a grade,
and methods to return the students in a grade and all the students in the school.

### Reasonable Solution
	
```python
from collections import defaultdict


class School(object):

    def __init__(self, school_name: str = ''):
        self.school = defaultdict(list)
        self.name = school_name

    def add_student(self, name: str, grade: int):
        self.school[grade].append(name)

    def grade(self, num: int) -> list:
        return sorted(self.school[num])

    def roster(self) -> list:
        lst = [self.grade(num) for num in sorted(self.school.keys())]
        return [child for clss in lst for child in clss]
```

### What To Look For

#### Delegation

The roster() method should call the grade() method to produce the list. 

#### When To Sort

The lists of students returned should be sorted.  
The sorting is best done using Python functions.  

Should the sorting happen upon insertion or when 
a method is called to return a list? 
Different assumptions will lead to different estimates of time. 
The tests only call for a list at the end, so there is no 
advantage to sorting upon addition. Were this a
real application, we would look for a list more 
frequently than we would add a student, so
sorting after adding would be best.

You may want to raise the issue, but it isn't clear which is better.

#### Storing Students

Most of the solutions seem to use Dictionaries,
mapping grades to lists of names.  
A default dictionary makes the add() method simpler.  

An argument could be made for keeping things in a list of lists,
with one sublist per grade.  
We are not told which grades are at the school, but 
we could store empty lists for classes that haven't been
initialized, appending new sublists as needed. 
You will also see solutions that assume the grades
range from 1 to 9. 
A list of lists would simplify the traverse for the roster() method. 

You will also see solutions that simply store the 
data in one list as (grade, name) pairs, and traverse
the list looking for students in a particular grade.
This doesn't make add() much simpler, but 
increases the runtime of the other two methods,
and should be discouraged.

#### List Comprehension

The roster() method is a natural place for a list comprehension.

### Common Suggestions

This is a good place to introduce a number of ideas:
list comprehensions, default dictionary, sorting.

### Talking Points

Keep it simple!  Proper use of Python primitives
provides pleasant programs.  
