# Mentoring

### Problem and Challenges

The problem asks us to take an **int** and return a **str**.
We need to map potential factors 3, 5, and 7 to Pling, Plang, and Plong.
If the integer is not divisible by any of the factors, we must
return a string representing the number in base 10.

### Reasonable Solutions

This exercise is an early core exercise and is intended to introduce
simple concepts such as basic conditionals, modulo division, and string 
concatenation.

Therefore the following is considered both reasonable and acceptable:

```python
def convert(number: int) -> str:
  
    result = ''
    if number % 3 == 0:
        result += 'Pling'
    if number % 5 == 0:
        result += 'Plang'
    if number % 7 == 0:
        result += 'Plong'

    if not result:
        result = str(number)
    return result
```

A couple notes on the reasonable solution:

1. concatenation is efficient and reasonable here; `"".join(words)` is 
only more efficient with relatively large number of additions -- try to
avoid prematurely burdening the beginner student with optimization
2. similarly `if not number % 3` is slightly more efficient but will be
less readable for many than `if number % 3 == 0`

### Common Suggestions

#### Simplify the return statement

The final **if**/**return** block can be simplified in several ways:

```python
# ternary if statement
return result if result else str(number)

# leverage boolean OR
return result or str(number)

# cast either side of boolean OR
return str(result or number)
```

Note that the final one will not involve a copy since the value of 
**result** is always constrained enough to be interned.

#### Leverage the ternary if

```python
def convert(number: int) -> str:
  
    result = ''
    result += "Pling" if number % 3 == 0 else ""
    result += "Plang" if number % 5 == 0 else ""
    result += "Plong" if number % 7 == 0 else ""

    return result or str(number)
```

Not everyone likes the ternary **if** syntax, but it's quite workable
in this situation.

#### Alternatively, use multiplication of a str

```python
def convert(number: int) -> str:
  
    result = ''
    result += "Pling" * (number % 3 == 0)
    result += "Plang" * (number % 5 == 0)
    result += "Plong" * (number % 7 == 0)

    return result or str(number)
```

This helps introduce the **bool** type and the fact that it's just a 
numerical value. It also introduces the idea that a **str** can be
multiplied. The caveat is that the parentheses are required.

#### Use an iterable data structure

The approaches above all involve some repetition, and so would become 
unwieldy and difficult to maintain if the number of different factors 
were substantially increased.

The value of preparing for such scope creep in such a simple exercise
is debatable, but were it an issue then a more maintainable approach 
would be to use one of the many iterable data structures provided by 
Python's builtins via a _comprehension_.

##### Use tuple / list

```python
DROPS = (
   ('Pling', 3),
   ('Plang', 5),
   ('Plong', 7),
)

def convert(number: int) -> str:
    result = "".join(d for d, f in DROPS if not number % f)
    return str(result or number)
```

A **tuple** of tuples can be used because no dynamic resize of **DROPS** 
is necessary, and it's got a smaller footprint in memory than a **list** 
of lists, but either form would be acceptable.

This and the following solutions use a global constant rather than a local; 
this saves wasted allocation and deallocation if **convert** is called often, 
however a local constant would be acceptable as well.

Notice that a _generator comprehension_ is used to feed **str.join** rather 
than a _list comprehension_; again either form is acceptable, but this saves 
a small amount of memory and is slightly easier to read.

##### Use dict

```python
DROPS = {
    'Pling': 3,
    'Plang': 5,
    'Plong': 7,
}

def convert(number: int) -> str:
    result = "".join(d for d, f in DROPS.items() if not number % f)
    return str(result or number)
```

A **dict** can be used because it's a natural fit for mapping a string to a 
value, or vice versa, but it introduces some issues of its own:

1. Prior to Python 3.7 the keys of a dict were not guaranteed to be retained 
in insertion order. To be _reliably_ sorted before Python 3.7 either 
**sorted** or a **collections.OrderedDict** would be required. This introduces 
an extra set of concerns that don't exist with the solutions above.
2. The memory footprint of a dict is larger either the list of lists or 
the tuple of tuples, though not so substantially larger that it should be 
considered disqualifying. The student would however benefit from knowing the 
additional memory overhead exists.
3. The best argument against a dict in this case is that none of its 
strengths are used; a dict is meant to provide fast membership testing, but 
that's not an issue here. As used it's just a more expensive list / tuple.

##### Use enum.Enum

```python
from enum import Enum

class Drops(Enum):
    Pling = 3
    Plang = 5
    Plong = 7

def convert(number: int) -> str:
    result = "".join(d.name for d in Drops if not number % d.value)
    return str(result or number)
```

An **enum.Enum** introduces an import and the use of a class, but with the 
advantage of being unambiguous, immutable, inherently ordered, and arguably
the easiest of all of the above to read and maintain. However it does have 
the disadvantage of having the largest memory overhead of everything above, 
and is only available in Python 3.4 and newer.

### Talking Points

- Encourage simple & readable over complex & efficient
- Discuss possible maintainability / scalability problems & requirement drift
- Mention some of the available builtin data structures
- If looping is involved, encourage comprehension syntax
- Type annotations should be omitted for Python 2; for Python 3 they're optional, but it's worth encouraging the student to consider adding them and becoming familiar with them.
