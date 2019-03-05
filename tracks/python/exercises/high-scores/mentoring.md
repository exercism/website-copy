### Problem summary and challenges

This problem asks that students be familiar with **classes** and how they are created in Python.  In particular, the usage of **`__init__()`** , object attributes,  and the  **`self`** keyword.  

 Create a **class** that represents simple score tracking for a game.  Include:

-  A constructor
-  Attribute(s) to hold data
-  Associated methods that return  **latest**  score, **personal_best** score, and **personal_top_three** scores.  

   
Students also practice:

-  List indexing and slicing syntax
-  Strategies for computing/returning the maximum value in a list
-  Strategies for sorting/filtering lists 

  &nbsp;

### Reasonable solutions

```python
class HighScores(object):
    def __init__(self, scores):
        self.scores = scores

    def latest(self):
        return self.scores[-1]

    def personal_best(self):
        return max(self.scores)

    def personal_top_three(self):
        return sorted(self.scores, reverse=True)[:3]
```



```python
class HighScores(object):
    def __init__(self, scores):
        self.scores = scores
        self.sorted_scores = sorted(self.scores, reverse=True)

    def latest(self):
        return self.scores[-1]

    def personal_best(self):
        return self.sorted_scores[0]

    def personal_top_three(self):
        return self.sorted_scores[:3]
```



```python
class HighScores(object):
    def __init__(self, scores):
        self.scores = scores
        self.sorted_scores = sorted(self.scores)

    def latest(self):
        return self.scores[-1]

    def personal_best(self):
        return self.sorted_scores[-1]

    def personal_top_three(self):
        return self.sorted_scores[-1:-4:-1]
```

&nbsp;

### Common suggestions

- Use **`sorted()`** over **`sort()`**.   `sorted()` returns a _**copy**_ , `sort()` _**mutates in place**_.  

  Solutions that use `sort()` without first copying the data in `self.scores`  erase the "latest" score.  If `latest()` is called after the `sort()`, it will be inaccurate.

  

-  Use built-in functions like **`max(self.scores)`** -OR-  **`sorted(self.scores, reverse=True)[0]`**  over looping manually.   It's is more efficient than iterating through `self.scores` to find the largest value.

  

-  Using **`sorted(self.scores, reverse=True)[:3]`**  is preferable to  iterating through scores to find the three largest values.

  

- Checking  **`len(self.scores) < 3`**  is unnecessary if a list slice is used to make the three highest scores list.  Python will return a copy of the entire list if is is shorter than the requested list slice.

  

- A _negative index_ (e.g. **`self.scores[-1]`**) is preferred over performing a length-check  to get the index of the last element (e.g.**`self.scores[len(self.scores)-1]`**). 

  

- The syntax of  **`sorted(self.scores, reverse=True)[:3]`** is preferred over  **`sorted(self.scores, reverse=True)[0:3]`**.  All slices default to zero unless otherwise specified - so convention is to leave it off.

  &nbsp;

### Talking points

#### copying data and lists

- Python is _pass by object reference_.  You cannot copy list data by assigning a new variable name, you must copy data by calling `.copy()` or using slice syntax `copied_data = data[:]`

- **Indexing and slicing work from either direction**.  Positive numbers from the left (starting at 0), negative numbers from the right (starting at -1).

- To get the last item in a list, request the item at index **-1**.  No need to measure length to get at the index number.

- If Python is handed a list slice that is longer than the list _being sliced_, it will return a copy of the _entire list_.  No need to length check a list being sliced.  

  

#### classes

-  **`__init__()`** is the constructor for the class.  Anything written inside of **`__init()__`**  executes _**once**_ -- when someone "makes a new object":  `my_scores = HighScores()`. 

- **`self`** is a keyword that represents an _**object instance**_.  Any methods (including `__init__()`) intended to "belong" to an object  need `self` as their first argument.

-  `self` also denotes _**object attributes**_  :  `self.scores`, `self.sorted_scores`.  Data variables meant to be part of an object need `self` as part of their declaration.   Object attribute values can be changed _**per instance**_.

- In Python 3.5 and above, classes can be declared without `(object)` because it's **inferred**.  The parenthesis & class name only need to be included when you are inheriting directly from a class that's _**not**_ `object`.  The boilerplate has the `(object)` syntax for backward compatibility.

- Code inside methods runs _**on request**_.  Object methods are accessed from _outside_ the class using "dot notation" and the _**object instance name**_  (e.g. `my_scores.personal_top() ` or `my_scores.latest()`).  Object methods are accessed from _inside_ the class via `self`:  `self.personal_top()`, `self.latest()`.

  

&nbsp;

### Resources

#### blogs and tutorials

-  [**Object-Oriented Programming in Python 3**](https://www.digitalocean.com/community/tutorial_series/object-oriented-programming-in-python-3) a tutorial series on using/creating classes from Lisa Tagliaferri at DigitalOcean.  

- [**OOP in Python 3**](https://realpython.com/python3-object-oriented-programming/) a tutorial from Real Python.  Includes a "cheat sheet" for OOP.

-  [**Lists and Tuples in Python**](https://realpython.com/python-lists-tuples/#python-lists) from John Sturtz at Real Python.  Rundown on indexing, slicing and all things list and tuple.

- [**Is Python call-by-reference or call-by-value?  Neither**](https://jeffknupp.com/blog/2012/11/13/is-python-callbyvalue-or-callbyreference-neither/) an explainer from Jeff Knupp.  Details why assigning a new name doesn't copy data in Python.

  

#### links into Python 3 documentation

-  [**Data Structures in Python**](https://docs.python.org/3/tutorial/datastructures.html).  Describes list object methods, uses for lists, and comprehensions.

- [**`list.sort()`**](https://docs.python.org/3/library/stdtypes.html#list.sort)

-  [**`sorted()`**](https://docs.python.org/3/library/functions.html#sorted)

-  [**Sorting HOW TO**](https://docs.python.org/3/howto/sorting.html). Tips, theories, and "recipes" for using lists and sorting to manage data in Python.

-  [**`max()` built-in function**](https://docs.python.org/3/library/functions.html#max) 
- [**`heapq` & `heapq.nlargest`**](https://docs.python.org/3/library/heapq.html#heapq.nlargest).  A _heap_ implementation.  Can be used in place of `sorted()` or `max()` for small sets of values.

-  [**A First Look at Classes**](https://docs.python.org/3/tutorial/classes.html#a-first-look-at-classes) 









