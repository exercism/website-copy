### Reasonable solutions

```elixir
defmodule RomanNumerals do
  @dict [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  def numeral(number), do: do_numeral(number, "")

  defp do_numeral(0, acc), do: acc

  defp do_numeral(number, acc) do
    {arabic, roman} = @dict |> Enum.find(fn {n, _} -> n <= number end)
    do_numeral(number - arabic, acc <> roman)
  end
end
```

Given that this solution introduces a lot of concepts, it would also be
acceptable to use a `cond` statement like the solution below, matching for each
possibility. For beginners who have the tendency to do pattern matching, this
could be the first step to reach the solution above.

```elixir
defmodule RomanNumerals do
  def numeral(number), do: do_numeral(number, "")

  defp do_numeral(number, acc) do
    cond do
      number >= 1000 -> do_numeral(number - 1000, acc <> "M")
      number >= 900 -> do_numeral(number - 900, acc <> "CM")
      number >= 500 -> do_numeral(number - 500, acc <> "D")
      number >= 400 -> do_numeral(number - 400, acc <> "CD")
      number >= 100 -> do_numeral(number - 100, acc <> "C")
      number >= 90 -> do_numeral(number - 90, acc <> "XC")
      number >= 50 -> do_numeral(number - 50, acc <> "L")
      number >= 40 -> do_numeral(number - 40, acc <> "XL")
      number >= 10 -> do_numeral(number - 10, acc <> "X")
      number >= 9 -> do_numeral(number - 9, acc <> "IX")
      number >= 5 -> do_numeral(number - 5, acc <> "V")
      number >= 4 -> acc <> "IV"
      number == 0 -> acc
      true -> do_numeral(number - 1, acc <> "I")
    end
  end
end
```

### Common suggestions

#### Default arguments

Most students attempt to do two definitions and use the first to invoke the
second with an empty string as accumulator:

```elixir
def numeral(number), do: numeral(number, "")

def numeral(number, acc) do
  # ...
end
```

This can easily be condensed into a single definition with default arguments.
However, it should be noted that with this approach, `numerals/2` cannot be
private and the API with the second argument is exposed.

```elixir
def numeral(number, acc \\ "") do
  # ...
end
```

#### Map keys are not ordered

Some students create a map of integers to roman numerals, and then take the keys, assuming they are ordered. Such an approach would look like this:

```elixir
defmodule RomanNumerals do
  @integer_to_roman %{
    1 => "I",
    4 => "IV",
    5 => "V",
    9 => "IX",
    10 => "X",
    40 => "XL",
    50 => "L",
    90 => "XC",
    100 => "C",
    400 => "CD",
    500 => "D",
    900 => "CM",
    1000 => "M"
  }
 
 # ...

  def numeral(number, roman_temp) do
    Map.keys(@integer_to_roman)
    |> Enum.reverse()
    |> # more code ...
  end
end
```

While map keys most of the time seems to have a stable order, in reality they don't. The student could be pointed to the [documentation of the Map module](https://hexdocs.pm/elixir/Map.html) that state:

> ```elixir
> %{"one" => :two, 3 => "four"}
> %{3 => "four", "one" => :two}
> ```
>
> Key-value pairs in a map do not follow any order (that's why the printed map in the example above has a different order than the map that was created).

To get rid of the problem, the student should use an ordered data structure, like a list of tuples (see first reasonable solution), or sort the keys explicitly (but make sure it only happens once):
```elixir
Map.keys(@integer_to_roman)
|> Enum.sort(&>=/2)
```
