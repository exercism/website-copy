[comment] # (This error is raised when the solution uses a function header)

A function header (a function definition without a body) is only necessary for functions with default arguments that have multiple clauses.

```elixir
# necessary function header
def hello(what \\ "World")
def hello("Alice"), do: "Hello, darling!"
def hello(name), do: "Hello, #{name}!"
```

For functions with default arguments that only have a single clause, the default arguments can be specified directly in that clause.

```elixir
# preferred
def bye(name \\ "World"), do: "See you, #{name}!"

# not preferred - unnecessary function header
def bye(what \\ "World")
def bye(name), do: "See you, #{name}!"
```

The function `two_fer/1` only needs a single clause, and thus doesn't need a function header.
