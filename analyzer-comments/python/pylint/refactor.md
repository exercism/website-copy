# pylint refactor

**Line %{lineno} [_%{code}_]** was reported by Pylint:

%{message}.

This code is emitting a [code smell][code smell], and may be in need of
a re-write or refactor.
 This doesn't mean the code is incorrect or buggy in a _technical sense_, only that it
appears to have one or more patterns that could lead to _future_ bugs or maintenance issues.
Consider taking a closer look at it.

%Q{Instead of:\n\n```python\n#{bad_code}\n```\n}
%Q{Try:\n\n```python\n#{good_code}\n```\n\n}
%Q{Additional information:\n #{related_info}\n}
%{details}

[code smell]: https://en.wikipedia.org/wiki/Code_smell
