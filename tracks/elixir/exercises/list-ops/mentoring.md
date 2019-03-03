### Reasonable solutions

```elixir
defmodule ListOps do
  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  defp do_count([], total) do
    total
  end

  defp do_count([_h|t], total) do
    do_count(t, total + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    do_reverse(l, [])
  end

  defp do_reverse([h|[]], []) do
    h
  end

  defp do_reverse([], acc) do
    acc
  end

  defp do_reverse([h | t], acc) do
    do_reverse(t, [h | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    do_map(l, f, [])
  end

  defp do_map([], _f, acc) do
    acc |> reverse
  end

  defp do_map([h | t], f, acc) do
    do_map(t, f, [f.(h) | acc])
  end 

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    do_filter(l, f, [])
  end

  defp do_filter([], _f, acc) do
    acc |> reverse
  end

  defp do_filter([h | t], f, acc) do
    if (f.(h)) do
      do_filter(t, f, [h | acc])
    else
      do_filter(t, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
    do_reduce(l, acc, f)
  end

  defp do_reduce([], acc, _f) do
    acc 
  end

  defp do_reduce([h|t], acc, f) do
    do_reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    do_append(a, b, [])
  end

  defp do_append([], [], acc) do
    acc |> reverse
  end

  defp do_append(a, l, []) when is_list(l) and not is_list(a) do
    [a | l]
  end

  defp do_append([h|t], b, acc ) do
    do_append(t, b, [h | acc])
  end

  defp do_append([], [h|t], acc) do
    do_append([], t, [h | acc])
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    do_concat(ll, [])
  end

  defp do_concat([], a) do
    a |> reverse
  end
  
  defp do_concat([h|t], a) when is_list(h) do
    do_concat(t, append(h |> reverse , a))
  end

  defp do_concat([h|t], a) do
    do_concat(t, [h, a])
  end
end
```

### Common suggestions
 
#### Naming conventions

This is the first problem that students need to use helper functions
with a name similar to the public version.

There are two naming conventions here, per the [elixer style guide](https://github.com/christopheradams/elixir_style_guide)


#### Performance problems

Students frequently have solutions that time out.
Normally this is because they are reversing the entire list at each iteration.

#### Stretch solution

Suggest that the student implements all of these using their own reduce function.
