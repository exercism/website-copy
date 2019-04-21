### Reasonable solutions

```elixir
# Enum.map with case (and/or anonymous function) based approach
defmodule RNATranscription do
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    Enum.map(dna, fn nucleotide ->
      case nucleotide do
        ?G -> ?C
        ?C -> ?G
        ?T -> ?A
        ?A -> ?U
      end
    end)
  end
end
```

```elixir
# Enum.map from map of transformations
defmodule RNATranscription do
  @transformations %{
    ?G => ?C,
    ?C => ?G,
    ?T => ?A,
    ?A => ?U
  }

  def to_rna(dna) do
    Enum.map(dna, fn dna -> @transformations[dna] end)
    # or:
    # dna |> Enum.map(&Map.get(@transformations, &1))
  end
end
```


```elixir
# recursive function approach
defmodule RNATranscription do
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: to_rna(dna, '')

  defp to_rna('', rna), do: Enum.reverse(rna)
  defp to_rna([?G | rest], rna), do: to_rna(rest, [?C | rna])
  defp to_rna([?C | rest], rna), do: to_rna(rest, [?G | rna])
  defp to_rna([?T | rest], rna), do: to_rna(rest, [?A | rna])
  defp to_rna([?A | rest], rna), do: to_rna(rest, [?U | rna])
end
```

### Common suggestions

#### Use ?instead of 'char' for matches

Using charlist ('A' -> 'U') forces you to iterate over the charlist and concate the list of charlists later. Using chars directly (?A -> ?U) circumvents creating lists of (char) lists.

#### Use multiheaded anonymous function

It's arguable if using a multiheaded anonymous function is better as it might be harder to read for newcomers to the language. So instead of using case block (like in 1st reasonable approach), one would write:

```elixir
def to_rna(dna) do
  mapping = fn
    ?A -> ?U
    ?C -> ?G
    ?T -> ?A
    ?G -> ?C
  end

  Enum.map(dna, mapping)
end
```

It might make people aware pattern matching is everywhere.
