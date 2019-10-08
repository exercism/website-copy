<!--
This error is raised when the solution doesn't use default parameters
-->

Use a [default parameter](https://elixir-lang.org/getting-started/modules-and-functions.html#default-arguments) for this solution.

- [Default parameters](https://elixir-lang.org/getting-started/modules-and-functions.html#default-arguments) removes the need of writing duplicate function clauses for functions with different [arities](https://en.wikipedia.org/wiki/Arity).

```elixir
# Consider this function:
def foo(bar \\ "baz") do
  IO.puts(bar)
end
```

- This function now defines both `foo/0` and also `foo/1`
- if `foo()` is called, `"baz"` is written to the application group leader, which in turn writes to `stdout`
- if `foo("bar")` is called, `"bar"` is written to the application group leader which in turn writes to `stdout`

> When Elixir is compiled and run, the [BEAM VM](https://en.wikipedia.org/wiki/BEAM_(Erlang_virtual_machine)) starts a process known as the `group leader` which represents standard input and output, this process is shared with all other processes to abstract input and output operations

For reference:

- [Elixir-Lang - Getting Started - IO and the File System](https://elixir-lang.org/getting-started/io-and-the-file-system.html#processes-and-group-leaders)
- [Learn you some Erlang for great good - The application behavior](https://learnyousomeerlang.com/building-otp-applications#the-application-behaviour)
