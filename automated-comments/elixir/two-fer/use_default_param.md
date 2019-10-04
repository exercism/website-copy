<!--
This error is raised when the solution doesn't use default parameters
-->

Use a [default parameter](https://elixir-lang.org/getting-started/modules-and-functions.html#default-arguments) for this solution.

- [Default parameters](https://elixir-lang.org/getting-started/modules-and-functions.html#default-arguments) allows you to avoid writing duplicate function clauses for functions with different [arities](https://en.wikipedia.org/wiki/Arity).

```elixir
# Consider this function:
def foo(bar \\ "baz") do
  IO.puts(bar)
end
```

- This function now defines both `foo/0` and also `foo/1`
- if `foo()` is called, `"baz"` is put to the stdio
- if `foo("bar")` is called, `"bar"` is put to the stdio
