# pylint warning

**Line %{lineno} [_%{code}_]** was reported by Pylint:

%{message}.

There is an issue in the code that could lead to a bug or error in the program.
While this error might not be _severe_, it could lead to more severe issues in the future.
It is recommended the problem be addressed before proceeding further.

%Q{Instead of:\n\n```python\n#{bad_code}\n```\n}
%Q{Try:\n\n```python\n#{good_code}\n```\n\n}
%Q{Additional information:\n #{related_info}\n}
%{details}

