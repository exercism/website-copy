# use function level guard

[comment]: # (This error is raised when the solution uses guards, but not in the function clause)

Use [guards](https://hexdocs.pm/elixir/master/guards.html) in the function clause to prevent `two_fer/1` from executing code with non-binary inputs.

```elixir
def hello(what) when is_binary(what) do
  "Hello, #{what}!"
end
```

When a function gets called with arguments that don't match any of the given clauses, a `FunctionClauseError` is raised.

```elixir
hello(123)

# => ** (FunctionClauseError) no function clause matching in hello/1
#
#    The following arguments were given to Foo.hello/1:
#
#    # 1
#    123
```
