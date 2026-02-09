# pylint informational

**Line %{lineno} [_%{code}_]** was reported by Pylint:

%{message}.

There is `FIXME`/`TODO`/`XXX` style comment or other "informational" pattern or note in the code.
 These tags are often used to annotate places where code is stubbed out but needs work - or to highlight potential design flaws or bugs that need to be addressed in the future.

%Q{Instead of:\n\n```python\n#{bad_code}\n```\n}
%Q{Try:\n\n```python\n#{good_code}\n```\n\n}
%Q{Additional information:\n #{related_info}\n}
%{details}
