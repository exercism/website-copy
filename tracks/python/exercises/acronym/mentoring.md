# Mentoring

## Problem and challenges

The problem requires the student to split a string at word boundaries,
and select the first letter of each word.

## Reasonable solutions

There are two characters that require special attention: 
the hypen, used to tie together words such as "metal-oxide", 
and the underscore, which must not be included.  
The underscore can be silently removed, but the hypen marks 
the boundary between two words, and it is simplest to replace 
it with a space.

```python
def abbreviate(words):
    words = words.replace('_', '')
    words = words.replace('-', ' ')
    words = words.upper()

    return ''.join(word[0] for word in words.split(' ') if word)
```

### Assembling Strings

Some solutions will assemble the result string one character at a time:

```python
def abbreviate(words):
    words = words.replace('_', '')
    words = words.replace('-', ' ')

    word_list = words.split(' ')
    
    acronym = ""
    for word in word_list:
        if word:
            acronym = acronym + word[0].upper()

    return acronym
```

The student should be told about building lists and `join()`ing them.

### Regular Expressions

Regular Expressions can help to prune the cruft.
This version still uses string addition.

```python
import re
  
def abbreviate(words):
    acronym = ""

    for word in re.findall(r"[^\W_]+[']?[^\W_]*", words):
        acronym += word[0].upper()

    return acronym
```

### Common Suggestions

Filtering is better done by looking for letters than by looking 
for things that are not letters. However, the hypen has a
special place as a pseudo-space.  

As noted above, assembling a string character by character is slow.

Once string addition is replaced with list `join()`ing, it
is a natural place for a List Comprehension.

It would be better to call the string method upper() only once, 
at the start or end.

### Talking points

This is a simple problem: it should have a simple solution.

Little checking of inputs is required by the test cases, 
but solutions that do deserve praise.
