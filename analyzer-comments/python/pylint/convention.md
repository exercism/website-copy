# pylint convention

**Line %{lineno} [_%{code}_]** was reported by Pylint:

%{message}.

This code doesn't follow general [Python code style][code style] conventions.
While this type of issue generally doesn't affect the way code _executes_, it can hurt readability or the performance of automated tools such as documentation generators or test runners.

%Q{Instead of:\n\n```python\n#{bad_code}\n```\n}
%Q{Try:\n\n```python\n#{good_code}\n```\n\n}
%Q{Additional information:\n #{related_info}\n}
%{details}

[code style]: https://www.python.org/dev/peps/pep-0008/
