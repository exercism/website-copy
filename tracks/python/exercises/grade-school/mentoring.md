# Mentoring

## Problem and Challenges

The primary challenge of this exercise is to implement a class that acts as a 
simple database that represents the students assigned to each grade in a 
school. Each student has a unique first name -- the student does not need to 
consider name collisions -- and is assigned to a single integer grade.

Three methods must be implemented: one to add a new student and their grade
assignment, one to return every student in a given grade (sorted by name), and
one to return the roster of all students in all grades, sorted first by grade
and then by name.

The secondary, bonus challenge is to address the problem of mutability by 
reducing or eliminating the ability of the user to mutate the underlying
database and change the results without using the "public" API presented in
our class.

## Reasonable Solutions

### Using a dictionary as a database

A straightforward approach is to use a dict as the database.

```python
class School:
    def __init__(self):
        self._db = {}

    def add_student(self, name, grade):
        self._db.setdefault(grade, [])
        self._db[grade].append(name)

    def roster(self):
        return [n for g in sorted(self._db) for n in self.grade(g)]

    def grade(self, num):
        if num not in self._db:
            return []
        return sorted(self._db[num])
```

This is simple enough, and introduces the **dict.setdefault** method, but it
requires some book-keeping to allow **School.grade** to handle grades that 
haven't yet had students added. A common suggestion is to instead leverage 
**collections.defaultdict**, as it will remove a few lines and do the 
book-keeping automatically. However this introduces a new wrinkle: if 
**School.grade** is ever called with an unknown grade number an empty list 
will automatically be inserted for that grade. In some implementations this
will force the student to filter out empty grades in **School.roster**.

Another common approach is for **Student.add_student** to do an in-place 
`self._db[grade].sort()` after each student is inserted. This removes
the need for most of the **sorted** calls in **Student.grade** and 
**Student.roster**, however it's a relatively costly, since every later call
to **add_student** necessarily receives a list that's already sorted. If you 
see this suggest **bisect.insort** instead.

### Using a list of tuples as a database

An alternative approach is to use a list of tuples as the database:

```python
from bisect import insort

class School:
    def __init__(self):
        self._db = []

    def add_student(self, name, grade):
        insort(self._db, (grade, name))

    def roster(self):
        return [n for _, n in self._db]

    def grade(self, grade_number):
        return [n for g, n in self._db if g == grade_number]
```

This dramatically simplifies both **Student.grade** and **student.roster**, 
and (with **bisect.insort**) leverages the natural sort order of tuples to
keep everything in its most-commonly-required sort order at all times. Finding
the students in a given grade is now O(N) instead of the nicer O(1) with a 
dictionary, but realistically the two are identical for the input constraints
of the problem as stated.

### Using a tuple of tuples as a database

Here we have the first example of a solution that addresses the issue of 
mutability; in both of the above directy mutation of the underlying database
was possible, but here we eliminate that fault by simply creating a new
immutable database after each insertion.

```python
from bisect import bisect

class School:
    def __init__(self):
        self._db = ()

    def add_student(self, name, grade):
        entry = (grade, name)
        index = bisect(self._db, entry)
        self._db = self._db[:index] + (entry,) + self._db[index:]

    def roster(self):
        return [n for _, n in self._db]

    def grade(self, grade_number):
        return [n for g, n in self._db if g == grade_number]
```

### Using a database as a database

We're not here to teach SQL, but the more advanced student will discover (or 
will want to know) that in Python we can always address all of the compromises 
described above (and several we haven't, like persistance of our database) 
using the real-world, battle-tested SQL RDBMS that ships with the language.

And in not many more lines than the hacks above.

```python
import sqlite3

class School:
    def __init__(self):
        self._db = sqlite3.connect(":memory:")
        query = "CREATE TABLE grades (grade INTEGER, student TEXT)"
        with self._db:
            self._db.execute(query)

    def add_student(self, name, grade):
        query = "INSERT INTO grades VALUES (?, ?)"
        with self._db:
            self._db.execute(query, (grade, name))

    def roster(self):
        query = "SELECT student FROM grades ORDER BY grade, student"
        return [s[0] for s in self._db.execute(query)]

    def grade(self, grade):
        query = "SELECT student FROM grades WHERE grade=? ORDER BY student"
        return [s[0] for s in self._db.execute(query, (grade,))]
```

### What to Look For

#### Data structure choice matters

As you've seen above the data structure chosen for the database itself 
determines most of the implementation details. Encourage students to think
of this as a real-world database problem: there are multiple competing tools
available, each with its own strengths and weaknesses, so given what you know
about the data is there an _optimimum_ data structure to choose?

#### When sort order matters, consider when it matters to sort

In both the reporting functions the sort order matters, but if the database
hasn't actually been modified between reports then your program may spend
a considerable amount of time and energy on producing a sort order that will
simply be discarded, even if it could speed up inserts later. It helps to 
know that there are efficient algorithms for working with already-sorted data.
Since this exercise naturally allows you to keep your database in the 
appropriate sort order from moment zero, they may be worth looking into.

#### Beware of giving back direct access to mutable objects

In the dictionary-style solutions quite a few students will reflexively add 
a `return` statement at the bottom of **School.add_student** that returns 
either the database or the grade the student was inserted in. If those are
mutable structures then the student has inadvertently given the caller the
ability to directly mutate the data.

Another approach to trying to solve the mutability issue is to use the
`@property` decorator to make a "read-only" getter that itself returns 
the underlying data: this stops the caller from _assigning_ to that name,
it stops no one from mutating the object that name refers to.

### Common Suggestions

This is a good place to introduce a number of ideas:

1. delegate responsibility: **School.roster** can benefit from using 
**School.grade**
2. list comprehensions: they're incredibly useful for filtering lists
3. dictionary defaults: the **dict.setdefault** method can replace a lot
of boilerplate; so can **collections.defaultdict**, though it brings its own
caveats
4. the difference between in-place sorting (which mutates your data) and 
**sorted** (which copies it)
5. a new stdlib module: the uses of **bisect.bisect** and **bisect.insort**

### Talking Points

Keep it simple! Proper use of Python primitives provides pleasant programs 
(probably).


