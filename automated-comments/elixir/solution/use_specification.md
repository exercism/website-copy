<!--
This warning is raised when the solution doesn't have a type specification
-->

Use a [type specification](https://elixir-lang.org/getting-started/typespecs-and-behaviours.html#types-and-specs) (`@spec`) to communicate the intended contract between function inputs and output.

- Elixir is a dynamically typed language, so types of data are only checked at run time, using type specification allows linters and static analysis like [`Dialyxir`](https://hexdocs.pm/dialyxir/readme.html) (based on Erlang's [Dialyzer](http://erlang.org/doc/man/dialyzer.html))
- You can find a [complete list](https://hexdocs.pm/elixir/typespecs.html#basic-types) of all the built-in types in the [language documentation](https://hexdocs.pm/elixir/typespecs.html#content)
- types can be specified with or without brackets -- `atom()` vs `atom`
  - the exercism elixir style is to specify without brackets.

```elixir
# Example 1
@spec add_one(int) :: int
def add_one(n) when is_integer(n) do
  n + 1
end

# Example 2
@spec hello(String.t) :: String.t
def hello(what \\ "world") when is_binary(what) do
  "Hello, #{what}"
end
```
