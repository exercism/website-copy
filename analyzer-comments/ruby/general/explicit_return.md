# explicit return

Remove the explicit return to simplify the method.

In Ruby, a method will return the result of the last evaluated statement. Explicitly using the `return` keyword is therefore unnecessary, except when returning early in a method.

For example, this will print `16` as the `multiply` method returns the result of `a * b`, its final expression.

```ruby
def multiple(a, b)
  a * b
end

print multiple(2, 8)
```
