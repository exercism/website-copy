# Mentoring

## Reasonable solutions

```elixir
defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec length(list) :: non_neg_integer
  def length(list), do: do_length(list, 0)

  defp do_length([_h | t], total), do: do_length(t, total + 1)
  defp do_length([], total), do: total

  @spec reverse(list) :: list
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([h | t], acc), do: do_reverse(t, [h | acc])
  defp do_reverse([], acc), do: acc

  @spec map(list, (any -> any)) :: list
  def map(list, func), do: do_map(list, [], func)

  def do_map([h | t], acc, func), do: do_map(t, [func.(h) | acc], func)
  def do_map([], acc, _func), do: reverse(acc)

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(list, func), do: do_filter(list, [], func)

  defp do_filter([h | t], acc, func), do: do_filter(t, (func.(h) && [h | acc]) || acc, func)
  defp do_filter([], acc, _func), do: reverse(acc)

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl([h | t], acc, func), do: foldl(t, func.(h, acc), func)
  def foldl([], acc, _func), do: acc

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr([], acc, _), do: acc
  def foldr([h | t], acc, f), do: f.(h, foldr(t, acc, f))

  @spec append(list, list) :: list
  def append(list1, list2), do: list1 |> reverse() |> do_append(list2)

  defp do_append([h | t], list), do: do_append(t, [h | list])
  defp do_append([], list), do: list

  @spec concat([[any]]) :: [any]
  def concat(list), do: list |> reverse() |> foldl([], &append/2)
end
```

## Common suggestions

### Naming conventions

In this exercise students need to use helper functions with a name similar to the public version.

They should name the private function the same name as the public functions,
but starting with `do_`, according to the
[elixir style guide](https://github.com/christopheradams/elixir_style_guide#private-functions-with-same-name-as-public).

### Performance problems

Students frequently have solutions that time out.
Normally this is because they are reversing the entire list at each iteration.

### Stretch solution

Suggest that the student implements all of these using their own reduce function.
