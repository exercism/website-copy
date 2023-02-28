# no rescue

Do not use exceptions for flow control.
Try to solve this exercise without using `rescue`.

If you are using a standard library function with a name ending with a `!` (raises errors), look for an equivalent function without the `!` (often return `{:ok, result}` or `{:error, message}`).

Note: if you are seeing this automated comment on your solution, other automated comments might not be accurate.
Fix this problem first!

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
