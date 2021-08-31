# percent or "old style" formatting

This solution uses `%-formatting` or [`old-style formatting`](https://docs.python.org/release/3.9.6/library/stdtypes.html#old-string-formatting) for strings.

While `%-formatting` is an entirely valid approach, it can create representation or readability issues.
Using the method [`str.format()`](https://docs.python.org/3/library/stdtypes.html#str.format) or [`f-strings`](https://docs.python.org/3/reference/lexical_analysis.html#formatted-string-literals) (_AKA `formatted string literals` or `interpolated strings`_) can offer options that improve readability and make variable replacement within strings clearer.

The blog post [String Formatting in Python](https://realpython.com/python-string-formatting/) is a good starting point for understanding all of Python's string formatting options, and [Newer Python String Format Techniques](https://realpython.com/python-formatted-output/) also provides some good tips and tricks for using `str.format()` and `f-strings`.
