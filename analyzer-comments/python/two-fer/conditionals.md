# unnecessary conditionals

[Conditionals](https://github.com/exercism/python/blob/main/concepts/conditionals/introduction.md) are unnecessarily used in this solution.
It can be improved by making use of a `default argument` in combination with either [`str.format`](https://docs.python.org/3/library/stdtypes.html#str.format) or [`f-strings`](https://docs.python.org/3/reference/lexical_analysis.html#formatted-string-literals) (_otherwise known as `formatted string literals` or `interpolated strings`_).

See this post on [python default arguments](https://blog.finxter.com/python-default-arguments/) for more details.  
The blog post [string formatting in python](https://realpython.com/python-string-formatting/) can be a good starting for all of Python's string formatting options.
