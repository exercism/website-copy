# def with is_

[comment]: # (requires 2 params:)
[comment]: # (- expected: the corrected name)
[comment]: # (- actual: the incorrect name that the student used)

Elixir has specific naming conventions which include how to name [functions that return a boolean](https://hexdocs.pm/elixir/naming-conventions.html#trailing-question-mark-foo):

> Functions that return a boolean are named with a trailing question mark.

```elixir
# this is the expected name of functions that return a boolean

%{expected}

# this is the current name

%{actual}
```

Note that functions that return booleans and are valid in guards follow another convention and are named with a `is_` prefix (`defguard is_foo`). Both conventions must not mix.
