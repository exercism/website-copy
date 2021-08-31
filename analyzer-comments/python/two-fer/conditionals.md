# unnecessary conditionals

[Conditionals][conditionals] are unnecessarily used in this solution.
Making use of a [`default argument`][default argument] in combination with either [`str.format`][str.format] or [`f-strings`][f-strings] (_otherwise known as `formatted string literals` or `interpolated strings`_) can make the code clearer and less verbose.

See this post on [python default arguments][python default arguments] for additional details.
The blog post [string formatting in python][string formatting in python] can also be a good starting point for learning about Python's string formatting options.

[conditionals]: https://github.com/exercism/python/blob/main/concepts/conditionals/introduction.md
[str.format]: https://docs.python.org/3/library/stdtypes.html#str.format)
[f-strings]: https://docs.python.org/3/reference/lexical_analysis.html#formatted-string-literals
[default argument]: https://docs.python.org/3/tutorial/controlflow.html#default-argument-values
[python default arguments]: https://blog.finxter.com/python-default-arguments/
[string formatting in python]: https://realpython.com/python-string-formatting/

