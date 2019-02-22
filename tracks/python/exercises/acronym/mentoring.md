### Problem and challenges

The problem requires the student to split a string at word boundaries,
and select the first letter of each word.

### Reasonable solutions

There are two characters that require special attention: 
the hypen, used to tie together words such as "metal-oxide", 
and the underscore, which must not be included.  
The underscore can be silently remmoved, but the hypen marks 
the boundary between two words, and it is simplest to replace 
it with a space.

```python
def abbreviate(words):
    words = words.upper()
    words = words.replace('_', '')      # Remove underscore
    words = words.replace('-', ' ')     # Transform hyphen

    tla = [ word[0] for word in words.split(' ') if word ]
    return ''.join(tla)
```

#### Assembling Strings

Some solutions will assemble the result string one character at a time:

```python
def abbreviate(words):
    words = words.replace('_', '')
    words = words.replace('-', ' ')

    word_list = words.split(' ')
    
    tla = ""
    for word in word_list:
        if word:
            tla = tla + word[0].upper()

    return tla
```

The student should be told about building lists and join() them.

#### Regular Expressions

Regular Expressions can help to prune the cruft:

```python
import re
def abbreviate(words):
    return "".join(item.upper() for item in re.findall(r"\b([a-zA-Z])", words))
```

### Common Suggestions

Filtering is better done by looking for letters than by looking 
for things that are not letters. However, the hypen has a
special place as a pseudo-space.  

As noted above, assembling a string character by character is slow.

Once string addition is replace with list joining(), this
is a natural place for a List Comprehension.

It would be better to call the string method upper() only once, 
at the start or end.

### Talking points

This is a simple problem: it should have a simple solution.

Little checking of inputs is required by the test cases, 
but solutions that do deserve praise.
