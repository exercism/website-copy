String concatenation with the + operator is a valid approach, but it can create maintenance and readability issues.
Using the method [`str.format()`][str.format()] or [`f-strings`][f-strings] (_AKA `formatted string literals` or `interpolated strings`_) can offer options that improve maintainability and make variable replacement within strings clearer.

The blog post [String Formatting in Python][string formatting in python] is a good starting point for understanding all of Python's string formatting options, and [Newer Python String Format Techniques][newer python string format techniques] also provides some good tips and tricks for using `str.format()` and `f-strings`.

[f-strings]: https://docs.python.org/3/reference/lexical_analysis.html#formatted-string-literals
[newer python string format techniques]: https://realpython.com/python-formatted-output/
[str.format()]: https://docs.python.org/3/library/stdtypes.html#str.format
[string formatting in python]: https://realpython.com/python-string-formatting/