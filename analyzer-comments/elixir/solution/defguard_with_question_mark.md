# defguard with question mark

Elixir has specific naming conventions which include how to name [functions that return booleans and are valid in guard clauses](https://hexdocs.pm/elixir/naming-conventions.html#is_-prefix-is_foo):

> Type checks and other boolean checks that are allowed in guard clauses are named with an `is_` prefix.

```elixir
# this is the expected name for functions that return booleans and are valid in guard clauses

%{expected}

# this is the current name

%{actual}
```
Note that functions that return booleans that are not valid in guard clauses follow another convention and are named with a `?` suffix (`def foo?`). Both conventions must not mix.
