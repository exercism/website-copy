# defmacro with `_is` and question mark

[comment]: # (requires 3 params:)
[comment]: # (- actual: the incorrect name that the student used)
[comment]: # (- option1: the correct name for functions)
[comment]: # (- option2: the correct name for guards)

Elixir has specific naming conventions which include how to name [functions that return booleans](https://hexdocs.pm/elixir/naming-conventions.html#trailing-question-mark-foo) and [checks that return booleans and are valid in guard clauses](https://hexdocs.pm/elixir/naming-conventions.html#is_-prefix-is_foo):

> Functions that return a boolean are named with a trailing question mark.

> Type checks and other boolean checks that are allowed in guard clauses are named with an `is_` prefix.

Macros can be used in both contexts, so the notation is case dependent, but both naming conventions must not mix.

```elixir
# this is the expected name of macros that return booleans

%{option1}

# this is the expected name of macros that return booleans and are valid in guard clauses

%{option2}

# this is the current name

%{actual}
```
