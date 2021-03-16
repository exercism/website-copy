# string concatenation

String concatenation is perfectly valid within Ruby, but a more common way to compose a string is with [string interpolation](http://ruby-for-beginners.rubymonstas.org/bonus/string_interpolation.html). For example:

```ruby
# Rather than:
"One for " + %{name_variable} + ", one for me"

# Consider:
"One for #{%{name_variable}}, one for me."
```
