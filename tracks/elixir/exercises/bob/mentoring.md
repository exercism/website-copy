### Reasonable solutions

```elixir
defmodule Bob do
  def hey(input) do
    cond do
      shouting_question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      shouting?(input) -> "Whoa, chill out!"
      silence?(input) -> "Fine. Be that way!"
      true -> "Whatever."
    end
  end

  defp shouting_question?(input) do
    question?(input) && shouting?(input)
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end

  defp shouting?(input) do
    String.upcase(input) == input && String.downcase(input) != input
  end

  defp silence?(input) do
    String.trim(input) == ""
  end
end
```

### Common suggestions

#### `is_shouting`

If a solution uses names like `is_shouting` and `is_question`,
it can be pointed out that Elixir has the following naming convention:
- `is_foo` should only be used for macros that can be used in guard clauses,
- `foo?` should be used otherwise.

Sources:
- https://github.com/rrrene/elixir-style-guide#predicates
- https://github.com/christopheradams/elixir_style_guide#predicate-macro-names-with-guards
- https://github.com/lexmag/elixir-style-guide#predicate-funs-name

#### Usage of regular expressions

This exercise can be solved without regular expressions and a student could be encouraged to try to do that.
 - Regular expressions are not known for their readability. `String.ends_with?(input, "?")` is more obvious than `Regex.match?(~r/\?$/, input)`.
 - It is a good habit to use simple tools for simple problems and advanced tools for advanced problems.
 - Elixir developers should be familiar with the `String` module and the functions it offers.
