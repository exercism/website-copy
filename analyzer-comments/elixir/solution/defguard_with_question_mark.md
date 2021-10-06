# defguard with question mark

[comment]: # (requires 2 params:)
[comment]: # (- expected: the corrected name)
[comment]: # (- actual: the incorrect name that the student used)

Elixir has specific naming conventions which include how to name [checks that return booleans and are valid in guard clauses](https://hexdocs.pm/elixir/naming-conventions.html#is_-prefix-is_foo):

> Type checks and other boolean checks that are allowed in guard clauses are named with an `is_` prefix.

These types of checks include some built-in functions, some macros and guards.

```elixir
# this is the expected name for checks that return booleans and are valid in guard clauses

%{expected}

# this is the current name

%{actual}
```
Note that functions and macros that return booleans that are not valid in guard clauses follow another convention and are named with a `?` suffix (`def foo?`, `defmacro foo?`). Both conventions must not mix.
