# Mentoring

### Problem Summary and Challenges

This problem asks that students be familiar with **lists** and list manipulation in Python.  In particular:

-  List indexing and slicing syntax
-  Strategies for computing/returning the maximum values in a list
-  Strategies for sorting/filtering lists 

  
### Reasonable Solutions
Canonical solution using the `max()` built-in to return `personal_best()`, and reverse `sorted()` for `personal_top_three`.
```python
    def latest(scores):
        return scores[-1]

    def personal_best(scores):
        return max(scores)

    def personal_top_three(scores):
        return sorted(scores, reverse=True)[:3]
```

Solution sorting in reverse order for `personal_best` and `personal_top_three`.  `personal_best()` returns index zero of the sorted scores.
```python
    def latest(scores):
        return scores[-1]

    def personal_best(scores):
        return sorted(scores, reverse=True)[0]

    def personal_top_three(scores):
        return sorted(scores, reverse=True)[:3]
```
Solution sorting without reversed. `personal_best()` returns index **-1** and `personal_top_three()` returns a slice from the right, using negative indexes.
```python
    def latest(scores):
        return scores[-1]

    def personal_best(scores):
        return sorted(scores)[-1]

    def personal_top_three(scores):
        return sorted(scores)[:-4:-1]
```
Another variation of this solution includes the start at -1 for slicing the result to `personal_top_three`. The last solution works due the step being -1. Since no start is defined the start will default to 0 and the first step will start at -1 due to the step being defined.
```python
    def personal_top_three(scores):
        return sorted(scores)[-1:-4:-1]
```

Since immutability has not yet been introduced, solutions that mutate the original list (`scores.pop()` or `scores.sort()`) are acceptable. However, take the opportunity to start introducing this concept in your comments.
```python
    def latest(scores):
        return scores.pop()

    def personal_top_three(scores):
        scores.sort(reverse=True)
        return scores[:3]
```

### Common Suggestions

- Use **`sorted()`** over **`sort()`**. `sorted()` returns a _**copy**_ , `sort()` _**mutates in place**_.  
  Solutions that use `sort()` without first _copying_ the data in `scores` effectively erase the "latest" score. If `latest()` is called after the `sort()`, it will be inaccurate.
-  Use built-in functions like **`max(scores)`** -OR- **`sorted(scores, reverse=True)[0]`**  over looping manually.   It's is more efficient than iterating through `scores` to find the largest value.
-  Using **`sorted(scores, reverse=True)[:3]`** is preferable to iterating through scores to find the three largest values.
- Checking  **`len(scores) < 3`**  is unnecessary if a list slice is used to make the three highest scores list.  Python will return a copy of the entire list if it is shorter than the requested list slice.
- A _negative index_ (e.g. **`scores[-1]`**) is preferred over performing a length-check  to get the index of the last element (e.g.**`scores[len(scores)-1]`**). 
- The syntax of **`sorted(scores, reverse=True)[:3]`** is preferred over **`sorted(scores, reverse=True)[0:3]`**. All slices default to zero unless otherwise specified - so convention is to leave it off.

  
### Talking Points

#### Copying Data and Lists
- Python is _pass by object reference_.  You cannot copy list data by assigning a new variable name, you must copy data by calling `.copy()` or using slice syntax `copied_data = data[:]`
- **Indexing and slicing work from either direction**.  Positive numbers from the left (starting at 0), negative numbers from the right (starting at -1).
- Why _wouldn't_ you use `heapq.nlargest` for getting the top three scores?  What other strategies could you use within the class to create and manage the "top three" scores?  How does your strategy change if there are incoming scores to manage on top of the existing scores?

  
### Resources

#### Links to Python 3 Documentation
-  [**Data Structures in Python**](https://docs.python.org/3/tutorial/datastructures.html).  Describes list object methods, uses for lists, and comprehensions.
- [**`list.sort()`**](https://docs.python.org/3/library/stdtypes.html#list.sort) **|** [**`sorted()`**](https://docs.python.org/3/library/functions.html#sorted)
-  [**Sorting HOW TO**](https://docs.python.org/3/howto/sorting.html)  Tips theories and "recipes" for using lists and sorting to manage data in Python.
-  [**`max()` built-in function**](https://docs.python.org/3/library/functions.html#max) 
- [**`heapq` & `heapq.nlargest`**](https://docs.python.org/3/library/heapq.html#heapq.nlargest).  A _heap_ implementation.  Can be used in place of `sorted()` or `max()` for small sets of values.

#### Blogs and Tutorials
-  [**Lists and Tuples in Python**](https://realpython.com/python-lists-tuples/#python-lists) from John Sturtz at Real Python.  Indexing, slicing and all things list and tuple.
- [**Is Python call-by-reference or call-by-value?  Neither**](https://jeffknupp.com/blog/2012/11/13/is-python-callbyvalue-or-callbyreference-neither/) an explainer from Jeff Knupp.  Details why assigning a new name doesn't copy data in Python.
