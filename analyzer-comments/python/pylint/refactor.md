# pylint refactor

PyLint is reporting that this code has a [code smell](https://en.wikipedia.org/wiki/Code_smell), and might be in need of
a re-write or refactor. This doesn't mean your code is _incorrect_ or _buggy_ in a technical sense -- only that it
appears to have one or more patterns that could lead to _future_ bugs or maintenance issues, and you should take a closer look at it.

On line #%{lineno}, %{code} was reported: %{message}.

For more information on PyLint and PyLint checker message code %{code} see:

- [PyLint Basic Checker](http://pylint.pycqa.org/en/latest/technical_reference/features.html#basic-checker-messages)
- [PyLint Design Checker](http://pylint.pycqa.org/en/latest/technical_reference/features.html#design-checker-messages)
- [PyLint Imports Chekcer](http://pylint.pycqa.org/en/latest/technical_reference/features.html#imports-checker-messages)
- [PyLint Refactoring Checker](http://pylint.pycqa.org/en/latest/technical_reference/features.html#refactoring-checker)
- [PyLint Similarities Checker](http://pylint.pycqa.org/en/latest/technical_reference/features.html#similarities-checker)
