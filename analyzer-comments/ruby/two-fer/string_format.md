As well as the `String#%%` method, a common way to create strings in Ruby is to use [string interpolation](http://ruby-for-beginners.rubymonstas.org/bonus/string_interpolation.html). For example:

```ruby
# Rather than:
"One for %%s, one for me." %% %{name_variable}

# Consider:
"One for #{%{name_variable}}, one for me."
```
