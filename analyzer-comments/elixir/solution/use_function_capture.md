# use function capture

[comment]: # (requires 2 params:)
[comment]: # (- expected: the corrected function)
[comment]: # (- actual: the incorrect function that the student used)

When passing an existing function as an argument, make sure to capture it instead of creating a new anonymous function.

```elixir
# preferred: using capture notation

%{expected}

# discouraged: creating new anonymous functions

%{actual}
```
