# change codepoint to string directly

The easiest way to change a character codepoint to a string with that character is to use the `<<>>` special form. There is no need to use a charlist as an intermediate step.

```elixir
# instead of:
to_string([?A])
# => "A"

# use:
<<?A>>
# => "A"
```
