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
