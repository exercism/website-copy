### General Notes for Mentoring Python

There are a number of issues that arise in 
mentoring solutions.  This document is a place
to address issues that transcend a particular problem.

#### Strings

Creating strings in Python is relatively slow.
We should encourage students to do so infrequently.

##### Changing Case

We may want to convert case

```python
result = ''

for ch in word:
    if ch.lower() in matchingSet:
        result = result + ch.lower()

return result
```

Rather than change case one letter at a time, it is better
to change the whole word once
        
```python
result = ''

for ch in word.lower():
    if ch in matchingSet:
        result = result + ch

return result
```

##### Assembling Strings

The operation of adding two strings is slower
than appending to a list.  It is faster to 
append and join() than adding characters.
Rather than the solution above we wold prefer

```python
result = []

for ch in word.lower():
    if ch in matchingSet:
        result.append(ch)

return ''.joint(result)
```

#### Iterating and Indexing

Python provides the ability to iterate over many 
objects.  

Rather than 

```python
result = []
for i in range(len(string)):
    ch = string[i]
    if ch.isalpha()
        result.append(ch)
```

encourage the students to say

```python
result = []
for ch in string:
    if ch.isalpha()
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
for ch1, ch2 in zip(strand_a.lower(), strand_b.lower())
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
    if ch.isalpha()
        result.append(ch)
```

we can write the following list comprehension

```python
result = [ ch for ch in string if ch.isalpha() ]
```

#### Inclusion vs Exclusion

Many of the exercises call for pruning the input,
removing extraneous characters.  While it is easy
to pull together the set of things in the tests
that shouldn't be there, it is harder to specify
everything that shouldn't be there.

It is often simpler to specify what **should**
be in the string than to specify what shouldn't.
Test for what to include can be simpler than 
tests for what to exclude. 
