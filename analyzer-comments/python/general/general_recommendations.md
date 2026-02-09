1.  Get familiar with the conventions outlined in [PEP 8](https://peps.python.org/pep-0008/). While these are not "law", they are the standard used in the Python project itself and are a great baseline in most coding situations.
2.  Read and think about the ideas outlined in [PEP 20 (aka "The Zen of Python")](https://peps.python.org/pep-0020/). Like PEP 8, these are not "laws", but they are solid guiding principles for better and clearer Python code.
3.  Prefer clear and easy to follow code over comments. But DO comment where needed for clarity.
4.  Consider type hints where code is complex or confusing.
5.  Try to follow the docstring guidelines laid out in [PEP 257](https://peps.python.org/pep-0257/). Good documentation matters.
6.  Write unit tests, but don't obsess over 100% coverage or edge cases.
7.  Avoid [magic numbers](https://en.wikipedia.org/wiki/Magic_number_(programming)).
8.  Prefer [`enumerate()`](https://docs.python.org/3/library/functions.html#enumerate) over [range(len())](https://docs.python.org/3/library/functions.html#func-range) in loops that need both an index and element.
9.  Prefer [comprehensions](https://treyhunner.com/2015/12/python-list-comprehensions-now-in-color/) and [generator expressions](https://www.pythonmorsels.com/how-write-generator-expression/) over loops that append to a data structure. But don't [overuse comprehensions](https://treyhunner.com/2019/03/abusing-and-overusing-list-comprehensions-in-python/).
10.  Prefer [str.join()](https://docs.python.org/3/library/stdtypes.html#str.join) over other methods of string concatenation.
