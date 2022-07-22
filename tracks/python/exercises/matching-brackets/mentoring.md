# Mentoring

## Problem and Challenges

The problem asks you verify that all brackets in a string are properly paired and nested.

## Reasonable Solution

```python
def is_paired(input_string):
    unmatched = []
    matching = {")": "(", "]": "[", "}": "{"}
    for character in input_string:
        if character in matching.values():
            # Push a new context
            unmatched.append(character)
        if character in matching:
            if not unmatched:
                return False
            # Peek at the current context
            if unmatched[-1] == matching[character]:
                # Pop a context
                unmatched.pop()
            else:
                return False
    return not unmatched
```

## Talking Points

### Maintaining Context

The key to solving this problem is recognizing that the solution is all about _maintaining context_.
When processing an open bracket, the context changes to that bracket type, adding a new context.
Prior open brackets need to be preserved, but do not need to be accessed until the current context is closed.
When deciding if a given close bracket is valid, the current context (the last known open bracket) is all that is needed.
If the current context matches the close bracket, the context is closed.
If the current context does not match, the close bracket is invalid.

A stack provides a method for maintaining context: `stack.push()` to add a new context; `stack.pop()` to remove a context; and `stack.peek()` to check the current context.
Lastly, `len(stack)` is needed to check if there is any remaining context once the string is finished.

Python's list is a superset of a stack, with it's `list.append()`, `list.pop()`, `list[-1]`, and `len(list)`.

For the string `"[{()}]()[]"`, this is what the context looks like:

```
stack:      # initially empty
stack: [    # push("[")
stack: [{   # push("{")
stack: [{(  # push("(")
stack: [{   # pop(")")
stack: [    # pop("}")
stack:      # pop("]")
stack: (    # push("(")
stack:      # pop(")")
stack: [    # push("[")
stack:      # pop("]")
```

### Regular Expressions: Language Theory

Note: This section is heavy on the theory and light on details.
The intent is to provide direction if one would like to delve deeper into this topic.

Regular expressions are often a go-to for parsing strings.
However, standard regular expressions are a poor fit for this particular exercise.
Below is some theory which explains the issue.

In formal language theory, computer science and linguistics, the Chomsky hierarchy [Chomsky hierarchy][chomsky-hierarchy] is a hierarchy of *formal grammars*.
A grammar is a tool used to describe a *language*, such as mathematical expressions, a programming language or an HTML document.

Regular expressions provide a way to describe a "[regular language][regular-language]".
Regular languages are [context free][context-free], which means they cannot maintain a current context or operate based on contexts.
Languages which use a stack are called [context sensitive][context-sensitive] languages and *can* maintain a context.

Simple arithmetic expressions (e.g. `x = a + m * b`) are considered regular languages and can be matched using regular expressions.
However, languages such as HTML - or bracket matching, require a context sensitive grammar and **cannot** be matched using regular expressions.

While *formal* regular expressions cannot maintain context, there are *implementations* of regular expressions which do support parsing context sensitive grammars using [recursion][regex-recursion].
Using recusion, a grammar can support [recursive descent parsing][recursive-descent-parser] which, with the help of backtracking, forms a type of a context stack.

Python's standard `re` module does not support recursive regular expression.
As such, it cannot parse context sensitive grammars.
This is what makes it a poor fit for parsing context sensitive languages like HTML and matching brackets.

For those eager to explore regex-recursion, the third party [regex][pypi-regex-module] module provides support for recursive regex in Python.

[Rexegg][rexegg-site] also offers some great explanation and tips, as does this [Stack Overflow Post][so-recursive-regex-python].


[chomsky-hierarchy]: https://en.wikipedia.org/wiki/Chomsky_hierarchy
[regular-language]: https://en.wikipedia.org/wiki/Regular_language
[context-free]: https://en.wikipedia.org/wiki/Context-free_language
[context-sensitive]: https://en.wikipedia.org/wiki/Context-sensitive_grammar
[regex-recursion]: https://www.regular-expressions.info/recurse.html
[pypi-regex-module]: https://pypi.org/project/regex/
[rexegg-site]: https://www.rexegg.com/regex-recursion.html
[so-recursive-regex-python]: https://stackoverflow.com/questions/23183777/recursive-regexp-in-python
[list-python]: https://docs.python.org/3/tutorial/datastructures.html#more-on-lists

[recursive-descent-parser]: https://en.wikipedia.org/wiki/Recursive_descent_parser
