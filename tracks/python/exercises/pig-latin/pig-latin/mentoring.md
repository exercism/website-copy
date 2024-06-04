# Pig Latin

## Introduction
Pig Latin is a fun way to play with words. In this exercise, you'll learn how to translate English sentences into Pig Latin by following a few simple rules. We'll break down the process step-by-step and provide you with clear code examples to help you understand and implement the translation.

## Pig Latin Rules
1. Words that start with a vowel (a, e, i, o, u):

_ Add "ay" to the end of the word.
_ Example: "apple" becomes "appleay".

Words that start with "xr" or "yt":

Add "ay" to the end of the word.
Example: "xray" becomes "xrayay".
Words that start with consonants:

Move all the consonants before the first vowel to the end of the word and then add "ay".
Example: "pig" becomes "igpay".
Words that have "qu" after consonants:

Move the consonants and "qu" to the end and add "ay".
Example: "square" becomes "aresquay".
Words with consonants followed by "y":

Move the consonants before "y" to the end and add "ay".
Example: "my" becomes "ymay".
Step-by-Step Implementation
Let's start by writing a function to translate a whole sentence into Pig Latin. We'll break it down into smaller, manageable tasks.

Step 1: Translate a Sentence
First, we'll create a function that splits a sentence into words, translates each word, and then joins the translated words back into a sentence.

python
Copy code
def translate_to_pig_latin(sentence):
    # Split the sentence into words
    words = sentence.split()
    
    # Translate each word to Pig Latin
    pig_latin_words = [translate_word_to_pig_latin(word) for word in words]
    
    # Join the translated words back into a sentence
    return ' '.join(pig_latin_words)
Step 2: Translate a Word
Next, we'll write a function to translate a single word into Pig Latin according to the rules.

python
Copy code
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
Putting It All Together
Now, let's combine these functions to see how they work together. We'll test the translation with a few examples.

python
Copy code
# Test the function
print(translate_to_pig_latin("apple"))  # appleay
print(translate_to_pig_latin("xray"))   # xrayay
print(translate_to_pig_latin("quick brown fox jumps over the lazy dog"))  # ickquay ownbray oxfay umpsjay overay ethay azylay ogday
print(translate_to_pig_latin("square"))  # aresquay
Detailed Explanation
translate_to_pig_latin(sentence):

This function takes a sentence, splits it into words, translates each word, and then joins the words back into a sentence.
translate_word_to_pig_latin(word):

This function translates a single word into Pig Latin according to the rules. It checks the initial characters of the word to determine the appropriate rule to apply.
Rules Implementation:

Rule 1: Checks if the word starts with a vowel or "xr" or "yt" and adds "ay" to the end.
Rule 3: Looks for "qu" and moves it with preceding consonants to the end.
Rules 2 and 4: Finds the first vowel or 'y' (not at the start), moves preceding consonants to the end, and adds "ay".
Conclusion
This approach ensures that we handle each rule for translating words into Pig Latin. By breaking the problem into smaller functions, we make the code easier to understand and maintain. Keep practicing with different sentences to get a better grasp of Pig Latin translation!
