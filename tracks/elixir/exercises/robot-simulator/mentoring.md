# Mentoring

## Reasonable solutions

### Sample GenServer solution
```elixir
defmodule RobotSimulator do
  defmodule Robot do
    @opaque t :: %Robot{direction: :north, position: {integer, integer}}
    defstruct direction: nil, position: nil
  end
  
  defguard is_direction(d) when d in [:north, :east, :south, :west]
  defguard is_rotation(cmd) when cmd in ["R", "L"] 

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  
  def create(direction \\ :north, position \\ {0 , 0})
  
  def create(direction, {e, n} ) when is_direction(direction) and is_integer(n) and is_integer(e) do
    %Robot{ direction: direction, position: {e, n}}
  end

  def create(direction, _) when is_direction(direction) do
    {:error, "invalid position"}
  end

  def create(_, _) do
    {:error, "invalid direction"}
  end

  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    do_simulate(robot, instructions |> String.codepoints() )
  end

  defp do_simulate(robot, [h | t]) when is_rotation(h) do
    do_simulate( %Robot{ robot | direction: calc_direction(robot.direction, h) }, t )
  end

  defp do_simulate(robot, ["A" | t]) do
    do_simulate( %Robot{ robot | position: calc_position(robot.direction, robot.position) }, t )    
  end

  defp do_simulate(robot, []) do
    robot
  end

  defp do_simulate(_robot, _instruction) do
    {:error, "invalid instruction"}
  end

  @spec calc_direction(direction :: atom, instructions :: String.t()) :: atom
  defp calc_direction(:north, "L"), do: :west
  defp calc_direction(:north, "R"), do: :east
  defp calc_direction(:east, "L"), do: :north
  defp calc_direction(:east, "R"), do: :south
  defp calc_direction(:south, "L"), do: :east
  defp calc_direction(:south, "R"), do: :west
  defp calc_direction(:west, "L"), do: :south
  defp calc_direction(:west, "R"), do: :north

  @spec create(direction :: atom, position :: {integer, integer}) :: {integer, integer}
  defp calc_position(:north, {e, n}), do: {e, n + 1}
  defp calc_position(:east,  {e, n}), do: {e + 1, n}
  defp calc_position(:south, {e, n}), do: {e, n - 1}
  defp calc_position(:west, {e, n}), do: {e - 1, n}

  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end
end
```

### Sample Recursive solution

```elixir
defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  defguard is_direction(direction) when direction in @directions
  defguard is_position(x, y) when is_integer(x) and is_integer(y)

  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, {x, y} = position)
      when is_direction(direction) and is_position(x, y) do
    %{position: position, direction: direction}
  end

  def create(direction, {x, y})
      when not is_direction(direction) and is_position(x, y) do
    {:error, "invalid direction"}
  end

  def create(_, _) do
    {:error, "invalid position"}
  end

  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes()
    |> Enum.reduce(robot, fn x, acc ->
      case acc do
        {:error, _} -> acc
        _ -> process_inst(acc, x)
      end
    end)
  end

  defp process_inst(robot, "R"), do: process_turn(robot, 1)
  defp process_inst(robot, "L"), do: process_turn(robot, -1)

  defp process_inst(%{direction: direction, position: position} = robot, "A") do
    %{robot | position: advance_position(position, direction)}
  end

  defp process_inst(_robot, _), do: {:error, "invalid instruction"}

  defp process_turn(%{direction: direction} = robot, direction_delta) do
    new_dir =
      @directions
      |> Enum.find_index(fn x -> x == direction end)
      |> Kernel.+(direction_delta)
      |> rem(4)
      |> (fn x -> Enum.at(@directions, x) end).()

    %{robot | direction: new_dir}
  end

  defp advance_position(position, direction) do
    direction
    |> direction_vector
    |> add(position)
  end

  defp add({a, b}, {c, d}), do: {a + c, b + d}

  defp direction_vector(:north), do: {0, 1}
  defp direction_vector(:south), do: {0, -1}
  defp direction_vector(:west), do: {-1, 0}
  defp direction_vector(:east), do: {1, 0}

  @spec direction(robot :: any) :: atom
  def direction(%{direction: d}), do: d

  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: p}), do: p
end
```

### Common suggestions

#### Use ```defguard``` or ```defguardp```

```defguard is_direction(direction) when direction in @directions```

#### Use parameter deconstruction

```def position(%{position: p}), do: p```

#### Use map update syntax

```%Robot{ robot | direction: calc_direction(robot.direction, h) }```
