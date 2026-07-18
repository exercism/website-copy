# Function Annotation Order

Conventionally, `@doc` function annotations should come before `@spec` function annotations, and `@spec` function annotations should come directly before the function. If the function has multiple clauses, function annotations should go before the first clause.

Example:

```elixir
@doc """
This function counts the number elements in a list
"""
@spec count(list(any())) :: integer()
def count([]), do: 0
def count([h | t]), do: 1 + count(t)
```
