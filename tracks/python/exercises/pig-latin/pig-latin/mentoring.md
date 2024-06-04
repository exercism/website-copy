# Pig Latin

### Reasonable solutions:
In Pig Latin:

1. Words that start with a vowel (a, e, i, o, u): Add "ay" to the end of the word.
> Example: "apple" becomes "appleay".

2. Words that start with "xr" or "yt": Add "ay" to the end of the word.
> Example: "xray" becomes "xrayay".

3. Words that start with consonants: Move all the consonants before the first vowel to the end of the word and then add "ay".
> Example: "pig" becomes "igpay".

5. Words that have "qu" after consonants: Move the consonants and "qu" to the end and add "ay".
> Example: "square" becomes "aresquay".

6. Words with consonants followed by "y": Move the consonants before "y" to the end and add "ay".
> Example: "my" becomes "may".

# Code
Let's write the Python code step-by-step to translate a sentence into Pig Latin.

```
def translate_to_pig_latin(sentence):
    # Split the sentence into words
    words = sentence.split()
    
    # Translate each word to Pig Latin
    pig_latin_words = [translate_word_to_pig_latin(word) for word in words]
    
    # Join the translated words back into a sentence
    return ' '.join(pig_latin_words)

def translate_word_to_pig_latin(word):
    # Rule 1: If the word starts with a vowel or "xr" or "yt"
    if word[0] in 'aeiou' or word.startswith('xr') or word.startswith('yt'):
        return word + 'ay'
    
    # Rule 3: If the word starts with consonants followed by "qu"
    if 'qu' in word:
        qu_index = word.index('qu')
        return word[qu_index + 2:] + word[:qu_index + 2] + 'ay'
    
    # Rule 2 and Rule 4: Move consonants before the first vowel to the end and add "ay"
    for i, char in enumerate(word):
        if char in 'aeiou' or (char == 'y' and i != 0):
            return word[i:] + word[:i] + 'ay'
    
    # Just in case, return the word as is (should not reach here)
    return word

# Test the function
print(translate_to_pig_latin("apple"))  # appleay
print(translate_to_pig_latin("xray"))   # xrayay
print(translate_to_pig_latin("quick brown fox jumps over the lazy dog"))  # ickquay ownbray oxfay umpsjay overay ethay azylay ogday
print(translate_to_pig_latin("square"))  # aresquay
```

# Detailed Steps:

1. translate_to_pig_latin(sentence): This function takes a sentence, splits it into words, translates each word, and then joins the words back into a sentence.
2. translate_word_to_pig_latin(word): This function translates a single word into Pig Latin according to the rules.
Example Run

```
print(translate_to_pig_latin("apple"))  
# Output: appleay

print(translate_to_pig_latin("xray"))   
# Output: xrayay

print(translate_to_pig_latin("quick brown fox jumps over the lazy dog"))  
# Output: ickquay ownbray oxfay umpsjay overay ethay azylay ogday

print(translate_to_pig_latin("square"))  
# Output: aresquay
```
