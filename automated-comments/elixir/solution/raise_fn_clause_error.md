<!--
This error is raised when the submission includes a call to
`raise FunctionClauseError` rather than having elixir fail in
matching the call to the two_fer function for non-string types.
-->

Do not directly call `raise FunctionClauseError`.

1. When elixir executes code it attempts to match [named functions](https://elixir-lang.org/getting-started/modules-and-functions.html#named-functions) call and parameters to each function from top to bottom.
2. If you use [guards](https://hexdocs.pm/elixir/master/guards.html), it is possible to prevent functions from being invoked with arguments that do not match the functions intended use.
3. If there is no match for a named function, a `FunctionClauseError` is raised by the BEAM VM at run time.
