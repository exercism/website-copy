### Reasonable solutions

```elixir
defmodule WordCount do
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> normalize()
    |> split
    |> frequencies()
  end

  defp normalize(string) do
    string
    |> String.downcase()
    |> String.replace("_", " ", global: true)
  end

  defp split(string) do
    ~r/\b[\w'-]+\b/u
    |> Regex.scan(string)
    |> List.flatten()
  end

  defp frequencies(strings) do
    Enum.frequencies(strings)
  end
end
```

```elixir
defmodule WordCount do
  @trim_quotes_around_word ~r/\s'([^']+(?='))'/
  @alphanumeric_chars_group ~r/[[:alnum:]-']+/u

  def count(sentence) do
    removed_quotes = Regex.replace(@trim_quotes_around_word, String.downcase("\s" <> sentence), "\s\\g{1}")

    Regex.scan(@alphanumeric_chars_group, removed_quotes)
    |> List.flatten()
    |> Enum.frequencies()
  end
end
```

```elixir
defmodule WordCount do
  def count(sentence) do
    sentence
    |> String.split(~r/[^[:alnum:]-']/u, trim: true)
    |> Enum.map(&String.trim(&1, "'"))
    |> Enum.frequencies_by(&String.downcase/1)
  end
end
```

### Common suggestions

#### Special characters

If a solution explicitly lists German and Polish characters to make the German and Polish test cases pass,
an alternative test case can be presented and the student asked to make this test pass too.

```elixir
test "French" do
  expected = %{"un" => 1, "café" => 1, "s'il" => 1, "vous" => 1, "plaît" => 1}
  assert WordCount.count("Un café s'il vous plaît") == expected
end
```

That should make the student realize that listing all special characters of a language they do not know
is not a practical solution.

#### Punctuation - `~r/[!@#$%:;^&*?]+/`

If a solution explicitly lists all punctuation characters necessary to make the tests pass,
an alternative test case can be presented and the student asked to make this test pass too.

```elixir
test "spanish question" do
  expected = %{"habla" => 1, "usted" => 1, "inglés" => 1}
  assert WordCount.count("¿Habla usted Inglés?") == expected
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
