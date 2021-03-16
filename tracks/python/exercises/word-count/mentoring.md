# Mentoring

## Problem and Challenges

The problem asks the for the count of
unique words in a string.

The solution must parse the text into words,
and then bin the words, returning a dictionary.

### Complications

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

Perhaps a simpler method yet is to explicitly match the three kinds of word described in the problem instructions, and use `re.findall` to extract a list of non-overlapping words that match this pattern. The `re.VERBOSE` flag can be used to produce a more readable regular expression with comments.

```python
import re, collections

def count_words(sentence):
    word_regex = re.compile(
        r"""
                [0-9]+              # A number...
            |   [a-z]+ ' [a-z]+     # or a word with an apostrophe...
            |   [a-z]+              # or a word without an apostrophe.
        """,
        re.VERBOSE
    )
    return collections.Counter(word_regex.findall(sentence.lower()))
```

It can be helpful to document regular expressions in this manner, as their dense syntax can be obscure. A potential source of trouble is the ordering of the three sub-expressions: the regular expression `[0-9]+|[a-z]+|[a-z]+'[a-z]+` will not work as the sub-expression `[a-z]+` will produce a match prematurely (before `[a-z]+'[a-z]+` has been tested).

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
