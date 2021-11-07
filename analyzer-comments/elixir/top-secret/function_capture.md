# function capture

When passing an existing function as an argument, make sure to capture it instead of creating a new anonymous function.

```elixir
# preferred:
# capture the existing function
&decode_secret_message_part/2

# not preferred: 
# creating new anonymous functions
&decode_secret_message_part(&1, &2)
fn ast, acc -> decode_secret_message_part(ast, acc) end
```
