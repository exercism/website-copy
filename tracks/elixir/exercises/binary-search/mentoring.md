### Reasonable solutions

```elixir
defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  
  def search({}, _), do: :not_found
  
  def search(numbers, key) do
    size = numbers |> tuple_size()
    do_search(numbers, key, 0, size - 1)
  end

  defp do_search(_, _, low, high) when low > high,  do: :not_found

  defp do_search(numbers, key, low, high) do

    guess = (low + high) |> div(2)   
    guess_value = Kernel.elem(numbers, guess)

    cond do
      guess_value == key -> {:ok, guess}
      guess_value < key -> do_search(numbers, key, guess + 1, high)
      guess_value > key -> do_search(numbers, key, low, guess - 1)
    end
  end
  
end
```

### Common suggestions

#### No Lists

This solution should avoid the obvious trick of converting to a list.
This would defeat the performance benefit of using a tuple.


#### Hint functions for the truely stuck

These are not easy to find given that the documention is in Kernel under guard clause functions:

- https://hexdocs.pm/elixir/Kernel.html#tuple_size/1
- https://hexdocs.pm/elixir/Kernel.html#elem/2

Some students will resort to the erlang versions.
