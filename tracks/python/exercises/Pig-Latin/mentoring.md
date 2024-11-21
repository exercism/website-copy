# Mentoring

## Problem and challenges

The problem requires the student to rearrange the English word based on the given rules in the instruction.

## Reasonable solutions

This exercise can be solved by using one `for` loop.

```
def translate(text):
    return ' '.join([pig(word) for word in text.split(' ')])


def pig(word):
    if word[0] not in 'aieou' and word[1:3] == 'qu':
        return word[3:] + word[:3] + "ay"
    if word[0] in 'aieou':
        return word + "ay"
    if word[:2] in ['yt', 'xr']:
        return word + "ay"
    if word[:2] in ['qu']:
        return word[2:] + word[:2] + "ay"
    if set('aieou') - set(word) == set('aieou') and 'yt' not in word:
        return word[1:] + word[:1] + "ay"
    return pig(word[1:] + word[0])
```

## Talking points

1. Students may be unfamiliar with `join()` and may use `for` loop or list comprehension to concatenate:

    ```
    my_list = ["apple", "banana", "cherry"]
    separator = ", "
    result = separator.join(my_list)
    print(result)
    # Output: "apple, banana, cherry"
    ```

2. Also students may be unfamiliar with `set()`:

    Here's a breakdown of how and why sets are used in this solution.
    - set('aieou') creates a set of all vowels.
    - set(word) creates a set of unique characters in the word.
    - set('aieou') - set(word) computes the difference between the set of vowels and the set of characters in the word.
    - If the result of this difference is equal to set('aieou'), it means that none of the vowels is present in the word.
    
    Using sets in this way simplifies the logic needed to check for the presence of vowels in a word, making the function both efficient and easy to understand.
    The set operations leverage Python's efficient data structures to handle membership and difference checks quickly, which is particularly useful when processing each word in a text for Pig Latin translation.


    suggest students to look at the basic operations on `set` if they are unfamiliar with it.
