# Mentoring

## Reasonable solutions

```elixir
defmodule Lasagna do
  def expected_minutes_in_oven, do: 40
  
  def remaining_minutes_in_oven(actual_mins), do: expected_minutes_in_oven() - actual_mins
  
  def preparation_time_in_minutes(num_layers), do: num_layers * 2
  
  def total_time_in_minutes(num_layers, actual_mins) do
    preparation_time_in_minutes(num_layers) + actual_mins
  end
  
  def alarm, do: "Ding!"
end
```

## Common suggestions


If a solution uses names like `is_cooked` and `is_ready`,
it can be pointed out that Elixir has the following naming convention:
- `is_foo` should only be used for macros that can be used in guard clauses,
- `foo?` should be used otherwise.

Sources:
- https://github.com/rrrene/elixir-style-guide#predicates
- https://github.com/christopheradams/elixir_style_guide#predicate-macro-names-with-guards
- https://github.com/lexmag/elixir-style-guide#predicate-funs-name

### Usage of regular expressions

This exercise can be solved without regular expressions and a student could be encouraged to try to do that.
 - Regular expressions are not known for their readability. `String.ends_with?(input, "?")` is more obvious than `Regex.match?(~r/\?$/, input)`.
 - It is a good habit to use simple tools for simple problems and advanced tools for advanced problems.
 - Elixir developers should be familiar with the `String` module and the functions it offers.

### Hint functions for the truly stuck

- [`String#trim/1`](https://hexdocs.pm/elixir/String.html#trim/1)
- [`String#ends_with?/2`](https://hexdocs.pm/elixir/String.html#ends_with?/2)
- [`String#downcase/2`](https://hexdocs.pm/elixir/String.html#downcase/2)
- [`String#upcase/2`](https://hexdocs.pm/elixir/String.html#upcase/2)
- `String.upcase(input) != String.downcase(input)` if there is a letter present.
