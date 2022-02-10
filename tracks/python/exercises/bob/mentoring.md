# Mentoring

## Reasonable solutions

A conditional structure with a single nested **if** can avoid duplicated effort:

```python
def response(hey_bob):
    """
    Answer for Bob.
    """
    hey_bob = hey_bob.strip()
    if not hey_bob:
        return "Fine. Be that way!"
    if hey_bob.isupper():
        if hey_bob.endswith("?"):
            return "Calm down, I know what I'm doing!"
        return "Whoa, chill out!"
    if hey_bob.endswith("?"):
        return "Sure."
    return "Whatever."
```

Alternatively, reserving the outcome of the two main tests can result in a flatter structure:

```python
def response(hey_bob):
    """
    Answer for Bob.
    """
    hey_bob = hey_bob.strip()
    if not hey_bob:
        return "Fine. Be that way!"

    is_yelling = hey_bob.isupper()
    is_question = hey_bob.endswith("?")

    if is_yelling and is_question:
        return "Calm down, I know what I'm doing!"
    if is_yelling:
        return "Whoa, chill out!"
    if is_question:
        return "Sure."
    return "Whatever."
```

It's also possible to maintain Single Entry Single Exit (SESE), though see Talking Points below.

```python
def response(hey_bob):
    """
    Answer for Bob.
    """
    answer = "Whatever."
    hey_bob = hey_bob.strip()
    if not hey_bob:
        answer = "Fine. Be that way!"
    else:
        if hey_bob.isupper():
            if hey_bob.endswith("?"):
                answer = "Calm down, I know what I'm doing!"
            else:
                answer = "Whoa, chill out!"
        elif hey_bob.endswith("?"):
            answer = "Sure."
    return answer
```

## Common suggestions
- use the standard methods of the **str** class to your advantage
  - the **str.isupper** method ignores the presence of characters that are non case-aware
  - the **str.endswith** method is more flexible than indexing / slicing and comparison
  - both **str.strip** and **str.rstrip** will convert an all-whitespace **hey_bob** to the empty string
- in this case it's acceptable to _shadow_ the the original, un-stripped **hey_bob** with one stripped of padding, since no part of the rest of the function is concerned with the un-stripped form
- try to eliminate unnecessary work; for instance, avoid checking if an empty **hey_bob** is a question or yelled
- try to eliminate duplicate work; neither of the other two checks need ever be run more than once
- helper functions _may_ help overall readability

## Talking points
- rather than have multiple **return** statements, you _may_ find it helpful to track the return value through the conditional tree as a variable, so that you have a single **return** statement; this is known as Single Entry Single Exit or SESE, however:
  - doing so without duplicating effort often results in structures that are more complicated and even less readable than the alternative
  - you eliminate the logical help that earlier **return** statements higher up in the code give you; the careful use of **if** and **elif** can return some of this, but multiple **if** statements can easily result multiple changes to the result
  - SESE is mainly a virtue in languages that have a _goto_ statement; as Python lacks any such functionality its benefits are far less clear; consider trying it both ways and see which is more readable to you
- in Python [truth-value testing][truth-value-testing] is the idiomatic way to check for the presence of an empty (`if not hey_bob:`) or non-empty (`if hey_bob:`) string; indeed it's the idiomatic way to check for the "empty" or "full" versions of all the builtin types and collections, and should generally be used in favor of direct comparison or length testing

[truth-value-testing]: https://docs.python.org/3/library/stdtypes.html#truth-value-testing
