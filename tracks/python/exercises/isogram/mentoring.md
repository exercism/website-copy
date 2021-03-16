# Mentoring

## Problem and challenges

The solution looks for duplicate letters.

## Reasonable solutions
	
This version searches for a second copy of each letter in turn:
	
```python
def is_isogram(string):
    string = string.lower()

    for i in range(len(string)):
        ch = string[i]

        if ch.isalpha():
            if ch in string[i + 1:]:
                return False

    return True
```

This version needs the index to construct the substring of remaining characters.

### Sorting the string
    
Another approach is to sort the input, and walk down it looking for
duplicates. However, Python provides a number of useful tools that allow
alternative approaches.  

### Trimming the string

If the approach is to remove non-letters, it is simpler to look for things that
belong (letters) than things that do not belong - a much harder list to define.

It is common to see students constructing strings by addition with a
fragment like this:

```python
result = ""
for ch in string:
	if ch.isalpha()
		result = result + ch
```

Building strings is slow in Python, and it is much better to create a list and join() it.

```python
result = []
for ch in string:
    if ch.isalpha():
        result.append(ch)

s = ''.join(result)
```

### Introducing List Comprehension

In turn, it is much more concise and faster to use a List Comprehension:

```python
result = [ch for ch in string if ch.isalpha()]

s = ''.join(result)
```

### Introducing Counter

The Counter collection provides a simple way to solve the problem:

```python
import collections

def is_isogram(string):
    string = string.lower()

    word = [ch for ch in string if ch.isalpha()]

    if not word:
        return True

    c = collections.Counter(word)
    
    letter, count = c.most_common(1)[0]
    
    return count == 1
```

#### Defective Solution using Handcrafted Counters 

The solution might define their own counters:

```python
def is_isogram(string):
    arr = [0] * 256

    for l in string.lower():
        if arr[ord(l)] == 0:
            arr[ord(l)] += 1
        elif (l != ' ') and (l != '-'):
            return False

    return True
```

This passes the unit tests, but assumes that the string holds only ASCII characters.
Point out that strings in Python 3 can hold Unicode characters that 
have an ord() larger than 255.

```python
    print('\U00000394')
    print(ord('\U00000394'))
```

Our first solution looked to the right for duplicates among the remaining characters: 
this one looks to the left at the characters we have already seen.
This idiom is best rewritten using sets or lists to hold the previous characters.

#### Sets

A similar idea can be implemented with sets:

```python
def is_isogram(string):
    string = string.lower()

    word = [ch for ch in string if ch.isalpha()]

    return len(set(word)) == len(word)
```

#### string count() method

A third way to look directly at letter counts is to use the string count() method:

```python
def is_isogram(string):
    lowerstr = string.lower()
    return all(lowerstr.count(c) == 1 for c in lowerstr if c.isalpha())
```

### Common Suggestions

This is a good place to introduce a number of ideas: List Comprehensions, Sets, or Counters.

### Talking points

Keep it simple!
