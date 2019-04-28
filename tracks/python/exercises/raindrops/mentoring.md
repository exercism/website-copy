### Problem and Challenges

The problem asks us to take an integer and return a string.
We need to map potential factors 3, 5, and 7 to Pling, Plang, and Plong.
If the integer is not divisible by any of the factors, we must
return a string representing the number in base 10.

### Reasonable Solutions

```python
def raindrops(val: int) -> str:

    sound_map = [
        (3, 'Pling'),
        (5, 'Plang'),
        (7, 'Plong'),
        ]

    lst = [sound for factor, sound in sound_map if not (val % factor)]

    if not lst:
        result = str(val)
    else:
        result = ''.join(lst)

    return result
```

#### Solutions That Need Work

Linear testing

```python
def raindrops(number) 
  
    result = ''
    if number % 3 == 0:
      result = result + 'Pling'
    if number % 5 == 0:
      result = result + 'Plang'
    if number % 7 == 0:
      result = result + 'Plong'

    if not result:
        result = str(number)

    return result
```

The solution contains
a sequence of if statements, rather than iterating
over some data structure that holds the pairs.

The problem is still fairly early in the Python 
Track, but you should make the case that, although
this solution passes the tests, it does not scale
to a solution when there are dozens of factors.

Tell the student that what sets Python apart
from many other languages is the rich set of 
data structures with full linguistic support.

The solution also uses string addition,
rather than appending to a list and joining.
See the General Issues discussion for more
on this common problem.
However, since there are a limited number
of possible additions, you may wish to overlook this
or to comment in passing.


#### The Dictionary

```python
def raindrops(val: int) -> str:

    sound_map = {
        3: 'Pling',
        5: 'Plang',
        7: 'Plong'
        }

    lst = [sound_map[i] for i in sorted(sound_map.keys()) if not (val % i)]

    if not lst:
        result = str(val)
    else:
        result = ''.join(lst)

    return result
```

The Dictionary seems like a step forward, but there are three arguments
against it. First, the keys to an ordinary dictionary are not
guaranteed to be presented in any particular order. Of course,
that can be addressed. The solution presented sorts the keys.

A stronger argument against it is the memory footprint for a
dictionary, which takes a great deal of memory to store
a hash table. Lists or tuples are much smaller.  

Finally, a dictionary provides a map to give
random access mapping keys to values. 
However, that is not the prolem we face here:
we are performing a sequential traverse of the 
keys. 
The dictionary isn't well suited for sequential
access, and the problem doesn't require random access. 
This problem is not a good showcase for a dictionary.   

### What to look for

Encourage students to use a list comprehension.

#### Many Happy Returns

All of the examples above have a single return.  
This is an aid in debugging: you can place a 
breakpoint on the return and see what the function
returns.  

There are a variety of viewpoints on the requirement
of a single return. The strongest argument for
relaxing it is to allow an early return from a 
complex routine: perhaps a return when the data
is invalid, or the answer is easy to compute. 
That argument doesn't apply here, so there is
little reason not to use a single return. 
