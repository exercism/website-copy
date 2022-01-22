# Mentoring

## Problem and challenges

The problem asks the student to score a string as a Scrabble(TM) word.
In Scrabble, rare letters are worth more than common letters.

## Reasonable solutions
	
The basic solution has two parts: defining a global dictionary using a 
dictionary literal called LETTER_VALUE, and using it. Using it is quite simple:

```python
def score(word):
    return sum( LETTER_VALUE[ch] for ch in word.upper() )
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
LETTERS_AND_SCORES = {
    1 : 'A, E, I, O, U, L, N, R, S, T',
    2 : 'D, G',
    3 : 'B, C, M, P',
    4 : 'F, H, V, W, Y',
    5 : 'K',
    8 : 'J, X',
    10: 'Q, Z'
}
    
LETTERS_TO_SCORES = { 
    ch: score for score, letters in LETTERS_AND_SCORES.items()
                    for ch in letters.split(', ') 
}

def score(word):
    return sum( LETTERS_TO_SCORES[ch] for ch in word.upper()  )
```

An arguably more readable and more resource efficient representation
would employ a tuple of tuples instead of a dictionary for the original 
table:

```python
LETTERS_AND_SCORES = (
#    Letter                           Value
    ('A, E, I, O, U, L, N, R, S, T',    1),
    ('D, G',                            2),
    ('B, C, M, P',                      3),
    ('F, H, V, W, Y',                   4),
    ('K',                               5),
    ('J, X',                            8),
    ('Q, Z',                            10)
)
    
LETTERS_TO_SCORES = { 
    ch: score for letters, score in LETTERS_AND_SCORES 
                    for ch in letters.split(', ') 
}
```

Or even better use an Enum:
```python
from enum import IntEnum

class Letters(IntEnum):
    A = E = I = O = U = L = N = R = S = T = 1
    D = G = 2
    B = C = M = P = 3
    F = H = V = W = Y = 4
    K = 5
    J = X = 8
    Q = Z = 10
    
def score(word):
     return sum(Letters[c] for c in word.upper())
```

The Enum approach has the benefit of not incurring any runtime costs, in
addition to being more readable than a dictionary literal, and being 
immutable.

## Common Suggestions

This is a good place to introduce a number of ideas:
Comprehensions (both dictionary, and generator given to the sum), 
the use of a dictionary to rapidly map between letters and values, 
and inverting a "dictionary". 


## Talking points

The presented solution uses global variables, 
without making a great case for them. 
Everything could be declared inside the function.

Since we recompute the dictionary each time score() is called, 
You could make a case for creating the reversed dictionary once.  

A downside for the suggested inversion approach is having an import 
runtime cost, whereas using dictionary literal directly without the 
dictionary inversion is more efficient.


