# percent or "old style" formatting

Your solution uses `%-formatting` or `old-style formatting` for strings.

While [`%-formatting`](https://docs.python.org/3/library/stdtypes.html#printf-style-string-formatting) is a completely valid approach, it does have a few representation or readability issues.
Using [`str.format()`](https://docs.python.org/3/library/stdtypes.html#str.format) or [`f-strings`](https://docs.python.org/3/reference/lexical_analysis.html#formatted-string-literals) (_otherwise known as `formatted string literals` or `interpolated strings`_) can offer some good options to improve readability and make variable replacement within strings clearer.

The blog post [string formatting in python](https://realpython.com/python-string-formatting/) can be a good starting point for understanding all of Python's string formatting options, and [Newer Python String Format Techniques](https://realpython.com/python-formatted-output/) also provides some good tips and tricks for using `str.format()` and `f-strings`.
