# prefer IO.puts in log_sent_email

When writing a line to a file, prefer `IO.puts/2` over `IO.write/2` because `IO.puts/2` automatically adds a newline character at the end.

```elixir
# preferred
IO.puts(pid, email)

# not preferred
IO.write(pid, email)
IO.write(pid, "\n")
```
