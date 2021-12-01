# Function Annotation Order

Developers can choose the order of the `@doc` and `@spec` modules attributes, but the Elixir community convention is to use `@doc` first and `@spec` next to the function.

Example:
```elixir
@doc """
This function counts the number elements in a list
"""
@spec count(list(any())) :: integer()
def count(list), do: length(list)
```
