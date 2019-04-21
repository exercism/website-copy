### Reasonable solutions

```elixir
# String.split based approach
defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> split
    |> count_words
  end

  defp split(sentence) do
    word_delimiters = ~r/[^\p{L}0-9-]+/u

    sentence
    |> String.downcase()
    |> String.split(word_delimiters, trim: true)
  end

  defp count_words(word_list) do
    word_list
    |> Enum.reduce(%{}, &increment/2)
  end

  defp increment(word, map) do
    Map.update(map, word, 1, &(&1 + 1))
  end
end
```

```elixir
# Regex.scan based approach
defmodule Words do
  def count(sentence) do
    sentence
    |> String.downcase()
    |> to_word_list()
    |> to_word_count_map()
  end

  defp to_word_list(sentence) do
    ~r/[[:alnum:]-]+/u
    |> Regex.scan(sentence)
    |> List.flatten()
  end

  defp to_word_count_map(word_list) do
    update_count = fn word, acc -> Map.update(acc, word, 1, &(&1 + 1)) end
    Enum.reduce(word_list, %{}, update_count)
  end
end
```

### Common suggestions

#### German `öüä`

If a solution explicitly lists German characters to make the German test case pass,
an alternative test case can be presented and the student asked to make this test pass too.

```elixir
test "Polish" do
  expected = %{"mam" => 1, "na" => 1, "imię" => 1, "łukasz" => 1}
  assert Words.count("Mam na imię Łukasz") == expected
end
```

That should make the student realize that listing all special characters of a language they do not know
is not a practical solution.

#### Punctuation - `~r/[!@#$%:;^&*?]+/`

If a solution explicitly lists all punctuation characters necessary to make the tests pass,
an alternative test case can be presented and the student asked to make this test pass too.

```elixir
test "question" do
  expected = %{"what" => 1, "is" => 1, "your" => 1, "name" => 1}
  assert Words.count("What is your name?") == expected
end
```

```elixir
test "spanish question" do
  expected = %{"habla" => 1, "usted" => 1, "inglés" => 1}
  assert Words.count("¿Habla usted Inglés?") == expected
end
```

#### `String.split` result includes empty strings

If the student handled a case for empty strings included in the output of `String.trim`,
it can be suggested to use the `trim: true` option.
```elixir
iex(3)> String.split("a  b  c  d", " ")
["a", "", "b", "", "c", "", "d"]
iex(4)> String.split("a  b  c  d", " ", trim: true)
["a", "b", "c", "d"]
```

#### `regex = ~r/bla/`

If the student named their variable with a regular expression `regex` or something similar,
it can be suggested that this is not a descriptive variable name.
A variable name for a regular expression should  make it possible to skim the code
and get the meaning of the regular expression without having to analyze it.

```elixir
redundant_punctuation = ~r/[^\w\s-_']/u
apostrophes_around_words = ~r/(?<=\W)'|'(?=\W)/u
word_delimiters = ~r/[^\p{L}0-9-]+/u
```
