# pylint convention

**Line %{lineno}** [_%{code}_]  :  %{message} was reported by Pylint.

Which means this code doesn't follow general [code style][code style] conventions.
While this type of issue generally doesn't affect the way code _executes_, it can hurt
readability or the performance of automated tools such as documentation generators or test runners.

[code style]: https://www.python.org/dev/peps/pep-0008/