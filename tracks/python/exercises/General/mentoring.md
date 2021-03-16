# Mentoring

## General Notes for Mentoring Python

There are a number of issues that arise in 
mentoring solutions.  This document is a place
to address issues that transcend a particular problem.

### Strings

Creating strings in Python is relatively slow.
We should encourage students to do so infrequently.

#### Changing Case

We may want to convert case

```python
result = ""

for ch in word:
    if ch.lower() in matchingSet:
        result = result + ch.lower()

return result
```

Rather than change case one letter at a time, it is better
to change the whole word once
        
```python
result = ""

for ch in word.lower():
    if ch in matchingSet:
        result = result + ch

return result
```

#### Assembling Strings

The operation of adding two strings is slower
than appending to a list.  It is faster to 
append() and join() than to add characters one by one.
Rather than the solution above we would prefer

```python
result = []

for ch in word.lower():
    if ch in matchingSet:
        result.append(ch)

return "".join(result)
```

#### Iterating and Indexing

Python provides the ability to iterate over many 
objects.  

Rather than 

```python
result = []
for i in range(len(string)):
    ch = string[i]
    if ch.isalpha():
        result.append(ch)
```

encourage the students to say

```python
result = []
for ch in string:
    if ch.isalpha():
        result.append(ch)
```

##### Enumerate

There are times when we need the value and the index,
as we do in the Luhn example

```python
for i in range(len(card_num)):
    num = int(card_num[i])
    # Double every other digit
    if i % 2:
        num = num * 2
```

In those cases, the built-in function enumerate() wraps the
iterable and returns the value and the index

```python
for counter, ch in enumerate(card_num):
    num = int(ch)
    if counter % 2:
        num = num * 2
```

##### Zipping Pairs

In other cases, we wish to traverse a pair of iterables.
Rather than 

```python
count = 0
for i in range(len(strand_a)):
    if strand_a[i] != strand_b[i]:
        count = count + 1
```

We can use the zip function to pair up the two strands:

```python
count = 0
for ch1, ch2 in zip(strand_a.lower(), strand_b.lower()):
    if ch1 != ch2:
        count = count + 1
```

#### Comprehensions

Comprehensions provide a succinct way to write certain
loops.  Because the interpreter knows what to expect,
they run faster than equivalent code.  They are widely
used, and students learning Python should master the
idiom.

Encourage students to use comprehensions where possible.
Rather assembling our list of letters as we did above,

```python
result = []
for ch in string:
    if ch.isalpha():
        result.append(ch)
```

we can write the following list comprehension

```python
result = [ch for ch in string if ch.isalpha()]
```

#### Inclusion vs Exclusion

Many of the exercises call for pruning the input,
removing extraneous characters.  While it is easy
to pull together the set of things in the tests
that shouldn't be there, it is harder to specify
everything that shouldn't be there.

It is often simpler to specify what **should**
be in the string than to specify what shouldn't.
Testing for what to include can be simpler than 
testing for what to exclude. 

#### Cruft

When solutions have extraneous material, suggest
edits.  The single most common example is a trailing
`pass` left over from the downloaded sourcefile.  
Leaving the `pass` is a sign that student doesn't
understand the keyword.  

#### Variable Names

In Python, we do not need to declare the type of a variable.  

```python
for i in text:
    if i.isalpha():
        lst.append(i)
```

The convention is that i is the name of an integer,
and ch is a better name for a character.  
Do everything you can to nudge the reader towards
understanding.  

#### Too Clever By Half 

If it takes you more than an instant to see what is going on, 
perhaps the solution could be clarified.

```python
def Hamming_distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError("Strands should be equal in length!")
    return sum([len(set(pair)) - 1 for pair in zip(strand_a, strand_b)])
````

This works to compute the Hamming distance between two strands,
but it is not the clearest way to express the thought.  
As Hal Abelson said, 
“Programs must be written for people to read, and 
only incidentally for machines to execute.”

Encourage clarity in everything.  

```python
def Hamming_distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError("Strands should be equal in length!")
    return sum(1 for ch1, ch2 in zip(strand_a, strand_b) if ch1 != ch2)
```

This makes clear that we are counting the number of pairs that don't match.

#### Many Unhappy Returns

There is an rule of thumb that functions should have a single return.
This is an aid in debugging: you can place a breakpoint on the statements
and see what the function returns.

There are a variety of viewpoints on the requirement
of a single return. The strongest argument for
relaxing it is to allow an early return from a
complex routine: perhaps a return when the data
is invalid, or the answer is easy to compute.

#### Long Happy Path

A related issue is described as the "Else Return".
This is an alternative return on the unhappy path. 
Consider the following example:

```python
def distance(strand_a, strand_b):
    if len(strand_a) == len(strand_b):
        strand_a = strand_a.lower()
        strand_b = strand_b.lower()
        count = 0
        for i in range(len(strand_a)):
            if strand_a[i] != strand_b[i]:
                count = count + 1
        return count
    else:
        raise ValueError("Strands must have the same length")
```

There are a number of issues here, but we are looking at one:
the position of the exception. 
By the time the reader hits the exception, they have been running
through the logic of the loop, and have long forgotten the original
test of length.  Even with the text in the exception explaining 
the problem, it is easier to understand in the following order.

```python
def distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError("Strands must have the same length")
    else:
        strand_a = strand_a.lower()
        ...
```

Of course, the `else` is optional at this point: Fat Elvis 
has left the building and we are all together on the happy path.  
