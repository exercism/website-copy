# Mentoring

## Reasonable solutions

```elixir
defmodule BinarySearch do
  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp search(_, _, left_index, right_index) when left_index > right_index do
    :not_found
  end

  defp search(numbers, key, left_index, right_index) do
    middle_index = Integer.floor_div(right_index + left_index, 2)
    middle = elem(numbers, middle_index)

    cond do
      middle == key -> {:ok, middle_index}
      middle > key -> search(numbers, key, left_index, middle_index - 1)
      middle < key -> search(numbers, key, middle_index + 1, right_index)
    end
  end
end
```

## Common suggestions

### Do not use lists

The advantage of the binary search algorithm is its lower time complexity compared to linear search - O(log(n)) vs O(n). However, this is only achievable if a data structure with random access is used. Elixir tuples offer random access, but Elixir lists do not. The operation to just read the length of the list will have a higher time complexity than the algorithm is supposed to.
