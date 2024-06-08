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

Exercise solved using two `for` loops.

```
def translate(sentence):
    words = sentence.split()
    pig_latin_words = [translate_to_pig_latin(word) for word in words]
    return ' '.join(pig_latin_words)


def translate_to_pig_latin(word):
    vowels = "aeiou"

    # Rule 1: Word begins with a vowel or starts with "xr" or "yt"
    if word[0] in vowels or word.startswith("xr") or word.startswith("yt"):
        return word + "ay"
    
    # Rule 3 and Rule 4 need to be checked within the loop
    for i, char in enumerate(word):
        if char == "u" and i > 0 and word[i-1] == 'q':
            # Rule 3: "qu" handling
            return word[i + 1:] + word[:i + 1] + "ay"
        elif char in vowels:
            # Rule 2: Move initial consonants to the end and add "ay"
            return word[i:] + word[:i] + "ay"
        elif char == 'y' and i > 0:
            # Rule 4: Consonants followed by "y"
            return word[i:] + word[:i] + "ay"
    
    # If no vowels are found, just add "ay" to the word (edge case)
    return word + "ay"
```

Prefer to use the first approach. Using multiple `for` loops in your code can sometimes lead to readability issues and inefficiencies. Remember that readability and maintainability are crucial.

## Talking points

1. Students may unfamiliar with `join()` may use `for` loop or list comprehension to concatenate:

    ```
    my_list = ["apple", "banana", "cherry"]
    separator = ", "
    result = separator.join(my_list)
    print(result)
    # Output: "apple, banana, cherry"
    ```

2. Also students may unfamiliar with `set()`:

    The `set()` function is a powerful data structure in Python.
    
    - A set is an unordered collection of unique elements.
    - You can create a set using curly braces {} or the set() constructor.
    
    Example:
    ```
    my_set = {1, 2, 3, 4}
    ```
    suggest students to look at the basic operations on `set`.


