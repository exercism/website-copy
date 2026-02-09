1.  Get familiar with the conventions outlined in [PEP 8][pep-8].
    While these are not "law", they are the standard used in the Python project itself and are a great baseline in most coding situations.
2.  Read and think about the ideas outlined in [PEP 20 (aka "The Zen of Python")][pep-20].
    Like PEP 8, these are not "laws", but they are solid guiding principles for better and clearer Python code.
3.  Prefer clear and easy to follow code over comments. But DO comment where needed for clarity.
4.  Consider using type hints to clarify your code.
    Explore the type hint [documentation][type-hint-docs] and [why you might not want to type hint][type-hint-nos].
5.  Try to follow the docstring guidelines laid out in [PEP 257][pep-257].
    Good documentation matters.
6.  Avoid [magic numbers][magic-numbers].
7.  Prefer [`enumerate()`][enumerate-docs] over [`range(len())`][range-docs] in loops that need both an index and element.
8.  Prefer [comprehensions][comprehensions] and [generator expressions][generators] over loops that append to a data structure.
    But don't [overuse comprehensions][comprehension-overuse].
9.  When joining more than few substrings or concatenating in a loop, prefer [`str.join()`][join] over other methods of string concatenation.
10.  Get familiar with Python's rich set of [built-in functions][built-in-functions]  and the [Standard Library][standard-lib].
     Go [here][standard-lib-overview] for a brief tour and some interesting highlights.

[built-in-functions]: https://docs.python.org/3/library/functions.html
[comprehension-overuse]: https://treyhunner.com/2019/03/abusing-and-overusing-list-comprehensions-in-python/
[comprehensions]: https://treyhunner.com/2015/12/python-list-comprehensions-now-in-color/
[enumerate-docs]: https://docs.python.org/3/library/functions.html#enumerate
[generators]: https://www.pythonmorsels.com/how-write-generator-expression/
[join]: https://docs.python.org/3/library/stdtypes.html#str.join
[magic-numbers]: https://en.wikipedia.org/wiki/Magic_number_(programming)
[pep-20]: https://peps.python.org/pep-0020/
[pep-257]: https://peps.python.org/pep-0257/
[pep-8]: https://peps.python.org/pep-0008/
[range-docs]: https://docs.python.org/3/library/functions.html#func-range
[standard-lib-overview]: https://docs.python.org/3/tutorial/stdlib.html
[standard-lib]: https://docs.python.org/3/library/index.html
[type-hint-docs]: https://typing.python.org/en/latest/index.html
[type-hint-nos]: https://typing.python.org/en/latest/guides/typing_anti_pitch.html
