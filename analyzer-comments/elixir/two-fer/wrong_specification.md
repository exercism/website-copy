<!--
This warning is raised when the solution has a typespec different than `two_fer(String.t()) :: String.t()`
-->

Make sure that the typespec for `two_fer/1` is correct. The function accepts one argument - a string, and returns one argument - also a string.

The right type for strings is [`String.t()`](https://hexdocs.pm/elixir/String.html#t:t/0).

> The types `String.t()` and `binary()` are equivalent to analysis tools. Although, for those reading the documentation, `String.t()` implies it is a UTF-8 encoded binary.

The [type `string()`](https://hexdocs.pm/elixir/typespecs.html#the-string-type) means a charlist, not an Elixir string.

> Elixir discourages the use of the `string()` type. The `string()` type refers to Erlang strings, which are known as "charlists" in Elixir. They do not refer to Elixir strings, which are UTF-8 encoded binaries. 
