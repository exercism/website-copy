# no rescue

Do not use exceptions for flow control. Try to solve this exercise without using `rescue`.

If you're using a standard library function whose name ends with `!` (raises errors), find an equivalent function.

Note: If you're seeing this automated comment on your solution, the other automated comments might not be accurate. Fix this problem first!

```elixir
# preferred: for example `case`

case Date.new(1999, 13, 1) do
  {:ok, date} -> date
  {:error, _} -> nil
end

# discouraged: rescuing exceptions

try do
  Date.new!(1999, 13, 1)
rescue
  ArgumentError ->
    nil
end
```
