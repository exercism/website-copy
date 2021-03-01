[comment]: # (This warning is raised when the solution doesn't use string interpolation)

Use [string interpolation](https://github.com/elixir-lang/elixir/blob/9cac52833e91b5ebac0d322b20e39605d8dafad9/lib/elixir/lib/string.ex#L20) to insert the `name` parameter into the output string.

- When possible it is recommended in the Exercism Elixir track to use string interpolation rather than string concatenation for readability.

```elixir
def hello(what) do
  "Hello, #{what}"
end
```

- [Any Elixir expression](https://github.com/elixir-lang/elixir/blob/9cac52833e91b5ebac0d322b20e39605d8dafad9/lib/elixir/lib/string.ex#L30) can be in the string interpolation syntax

```elixir
def pluralize_apple(n) when n >= 1 do
  "apple#{if n > 1, do: "s"}"
end
```
