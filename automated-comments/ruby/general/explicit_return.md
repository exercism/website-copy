Remove the explict return to simplify the method.

In Ruby, a method will return the object that was returned from the last evaluated statement. Explicitly using the `return` keyword is therefore unnecessary unless we are returning early in a method.

For example, this will print `16` as the `multiply` method will return the result of `a * b`, it's final expression.

```ruby
def multiple(a,b)
  a * b
end

print multiple(2, 8)
```
