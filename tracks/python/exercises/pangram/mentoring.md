# Mentoring

## Problem and Challenges

The problem asks you to determine if a given `string` (_or sentence_) is a [**pangram**][pangram] in English.

## Reasonable Solution

```python
import string


def is_pangram(sentence):
    sentence = sentence.lower()
    return all(letter in sentence for letter in string.ascii_lowercase)
```

## Talking Points

### Approaches

While this exercise is straightforward, there are many ways to approach it.
Most solutions do one of two things:

* Check if all the required letters are present.
* Compute the `set` of letters in the string and compare it to the required letters.

Some reasonable examples:

* `return len({item for item in sentence if item.isalpha()}) == 26`
* `return {item for iteim in sentence if item.isalpha()} == set(string.ascii_lowercase)`
* `return set(sentence).issuperset(set(string.ascii_lowercase))`

Some approaches worth discussing:

* Using a `dict` instead of a `set` to track letters found.
* Building new strings repeatedly, e.g. using `str.remove()` to iteratively remove letters then checking for `""`.
* Using a fixed string for the alphabet instead of leveraging the `string` module.

To help nudge students towards a solution using `all()`, encourage students to solve if a given sentence is a pangram _in their mind_ and consider how they do so.
Alternatively, encourage students to consider how they would teach a young child to solve if a given sentence is a pangram.

### Optimizations

* When checking if all the required letters are present, returning as soon as the first missing letter is detected improves efficiency.
* For smaller inputs, most solutions should perform very similarly.
  Differences show up in specific, large inputs, such as `string.ascii_lowercase + 'z' * 1_000_000` or `string.ascii_lowercase[2:] * 1_000_000` or `'a' * 1_000_000 + string.ascii_lowercase`.

### On Generators

Students unfamiliar with generators or `all()` may accomplish the same with a loop:

```python
    for letter in string.ascii_lowercase:
        if letter not in sentence:
            return False
    return True
```

[pangram] https://www.thoughtco.com/pangram-word-play-term-1691561
