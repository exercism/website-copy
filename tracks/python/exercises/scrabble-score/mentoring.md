### Problem and challenges

The problem asks the student to score a string as a Scrabble(TM) word.
In Scrabble, rare letters are worth more than common letters.

### Reasonable solutions
	
The basic solution has two parts: building a dictionary called
letter_value here, and using it. Using it is quite simple:

```python
def score(word: str) -> int:
    return sum( [ letter_value[ch] for ch in word.upper() ] )
```

You will see solutions that need to traverse
the alphabet looking for each letter.  Encourage the student to create the dictionary.  

So the real problem is setting the 26 values.
While it is possible to do this by hand, it is prone to error.
The problem statement includes the following table.

```text
Letter                           Value
A, E, I, O, U, L, N, R, S, T       1
D, G                               2
B, C, M, P                         3
F, H, V, W, Y                      4
K                                  5
J, X                               8
Q, Z                               10
```

It is a useful exercise to use this table to build a dictionary that 
maps numbers to strings, and then invert the dictionary
to get a mapping from letters to their value in the game.

This is less prone to error, and the editing is straightforward, 
and illustrates an important idea.

```python
numbers_to_letters = {
    1 : 'A, E, I, O, U, L, N, R, S, T',
    2 : 'D, G',
    3 : 'B, C, M, P',
    4 : 'F, H, V, W, Y',
    5 : 'K',
    8 : 'J, X',
    10: 'Q, Z'
    }

def rev(d: dict) -> dict:
    return { ch:val for val in d for ch in d[val] if ch.isalpha() }

def score(word: str) -> int:
    letter_value = rev(numbers_to_letters)
    return sum( [ letter_value[ch] for ch in word.upper() ] )
```

### Common Suggestions

This is a good place to introduce a number of ideas:
Comprehensions, the use a dictionary to rapidly 
map between letters and values, and inverting a dictionary. 


### Talking points

The presented solution uses global variables, 
without making a great case for them. 
Evertyhing could be declared inside the function,
since we recompute the dictionary each time score() is called.

You could make a case for creating the reversed dictionary once,
using the Singleton pattern.  

```python
numbers_to_letters = {
    1: 'A, E, I, O, U, L, N, R, S, T',
    2: 'D, G',
    3: 'B, C, M, P',
    4: 'F, H, V, W, Y',
    5: 'K',
    8: 'J, X',
    10: 'Q, Z'
    }

letter_value = {}

# Invert a dictionary
def rev(d: dict) -> dict:
    return {ch: val for val, text in d.items() for ch in text if ch.isalpha()}


def score(word: str) -> int:
    global letter_value
    if len(letter_value) == 0:
        letter_value = rev(numbers_to_letters)

    return sum([letter_value[ch] for ch in word.upper()])
```
