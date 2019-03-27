### Problem and Challenges

The problem asks the for the count of
unique words in a string.

The solution must parse the text into words,
and then bin the words, returning a dictionary.

#### Complications

In the following sentence, we
must retain the \' in "can't", and remove them from 
'large'.

    "Joe can't tell between 'large' and large."

One way to deal with this is the Python string method strip(),
which can remove a given character from the head and tail.

### Reasonable Solutions

Most solutions use Regular Expressions to 
remove the cruft and then bin the words in 
a dictionary.

```python
import re
  

def word_count(phrase):
    phrase = phrase.lower()
    phrase = phrase.replace('\t', " ")
    phrase = phrase.replace('\n', " ")
    phrase = re.sub('[!&@$%^&_,:.]', " ", phrase)
    phrase = phrase.split(" ")
    dic = {}
    for x in phrase:
        if x:
            if x[0] == "'":
                x = x.replace("'", "")
            if x not in dic:
                dic[x] = 1
            else:
                dic[x] = dic[x] + 1
    return dic
```

This solution could be improved with a defaultdict,
or, better yet, with a Counter.

The following solution uses a Counter, and has 
a cleaner approach to preparing the text.

```python
import re
import collections

def word_count(phrase):
    ignored_chars = '[.:!&@$%^\n]+'
    separator_chars = '[,_\t ]+'

    # build a lower case phrase without ignored characters
    clean_phrase = re.sub(ignored_chars, '', phrase.lower())

    # create words generator with enclosing ' or " removed
    words = (word.strip("'\"") for word in re.split(separator_chars, clean_phrase) if word)

    # return words counts
    return collections.Counter(words)
```

This version creates a Generator rather than
a List Comprehension.
Since we consume all the contents, the
Generator isn't any better than a List Comprehension.

### Common Suggestions

Regular Expressions are very useful in pruning the 
input.

At some point we need to ignore case.
This is usually done by converting to lower or 
upper case.
This should be done on the whole string, rather
than word by word.

Some search strings look for upper case letters
even through the string has been converted to lower case. Point that out.

If the student is using a plain dict, suggest a defaultdict.

The Counter makes the creation of the Dictionary
even easier.

As usual, this is a good place to discuss List Comprehensions or Generators.
