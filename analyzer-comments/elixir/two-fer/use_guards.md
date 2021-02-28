<!--
This error is raised when the solution doesn't use guards at all
-->

Use [guards](https://hexdocs.pm/elixir/master/guards.html) to prevent `two_fer/1` from executing code with non-binary inputs.

> Remember, [strings](https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html) are considered to be [binary data](https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html) in elixir.

```elixir
# Consider this function with a guard:
def hello(what) when is_binary(what) do
  "Hello, #{what}!"
end
```

> This guard can be tested in `iex`

```shell
iex> hello("world")
"Hello, world!"
iex> hello(123)
** (FunctionClauseError) no function clause matching in hello/1

    The following arguments were given to hello/1:

        # 1
        123
```
