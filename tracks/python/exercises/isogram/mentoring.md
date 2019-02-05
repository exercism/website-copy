### Problem and challenges

The solution looks for duplicate letters.

### Reasonable solutions
	
This version searches for a second copy of each letter in turn
	
```python
def is_isogram(string):

string = string.lower()

for i in range(len(string)):
	ch = string[i]

	if ch.isalpha():
		if (s.find(ch) > -1):
			return False

return True
```

This version needs the index to construct the substring of remaining characters.

#### Sorting the string
    
Another approach is to sort the input, and walk down it looking for
duplicates.  However, Python provides a number of useful tools that allow
alternative approaches.  

#### Trimming the string

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
result = ""
for ch in string:
	if ch.isalpha()
		result.append(ch)

s = ''.join(result)
```

#### Introducing List Comprehension

In turn, it is much more concise and faster to use a List Comprehension

```python
result = [ ch for ch in string if ch.isalpha() ]

s = ''.join(result)
```

#### Introducing Counter

The Counter collection provides a simple way to solve the problem.

```python
import string
import collections

def is_isogram(string):

	string = string.lower()

	word = [ch for ch in string if chisalpha() ]

	if not word:
		return True

	c = collections.Counter(word)
	for letter, count in c.most_common(1):
		return count == 1
```

#### Sets

A similar idea can be implemented with sets.

```python
import string
import collections

def is_isogram(string):

	string = string.lower()

	word = [ch for ch in string if chisalpha() ]

	return len(set(word)) == len(word)
```

### Common Suggestions

This is a good place to introduce a number of ideas: List Comprehensions, Sets, or Counters.

### Talking points

Keep it simple!
