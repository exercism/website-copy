# Use `||` instead of if-else

When wanting to change a value if it holds `nil` or any other falsy value, use the `||` operator instead of an if-else statement.
This is more idiomatic and concise and is also more performant.

The `||` operator will return the value to the left of the operator if it is truthy, otherwise it will return the value to the right of the operator.

For example:

```crystal
# Rather than:
value.nil? ? "default" : value

# Consider:
value || "default"
```
