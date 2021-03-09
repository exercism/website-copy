### Reasonable solutions

```elixir
defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(2) do
    """
    2 bottles of beer on the wall, 2 bottles of beer.
    Take one down and pass it around, 1 bottle of beer on the wall.
    """
  end
  
  def verse(1) do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end

  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(number) do
    """
    #{number} bottles of beer on the wall, #{number} bottles of beer.
    Take one down and pass it around, #{number-1} bottles of beer on the wall.
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range \\ 99..0) do
    range
    |> Enum.map_join("\n", &verse/1)
  end
end
```
 
### Common suggestions

#### Use string interpolation
"#{var}" can be used to include text into a string.
This is clearer than concatenation.

#### Use multi-line strings
```
"""
Multiline strings are far
easier to read
than embedded newlines
"""
``` 

#### Use explicit pattern matching rather than guard clause 
```
def verse(0), do: ...
```
is clearer than
```
def  verse(number) when number == 0. do: ...
```
