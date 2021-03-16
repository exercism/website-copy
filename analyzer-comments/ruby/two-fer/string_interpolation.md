# string interpolation

As well as string interpolation, another common way to create strings in Ruby is to use [String#%%](https://www.rubyguides.com/2012/01/ruby-string-formatting/) (perhaps read as "String format").
For example:

```ruby
"One for %%s, one for you" %% %{name_variable}"
```
