# Mentoring

This is a great opportunity to prepare for the track with attention to style conventions.

## Reasonable solutions

```ruby
module TwoFer
  def self.two_fer(name = 'you')
    "One for #{name}, one for me."
  end
end
```
Variations include using a `class` instead of `module`, using the [metaclass](https://yehudakatz.com/2009/11/15/metaprogramming-in-ruby-its-all-about-the-self/) instead of `self`, using [`module_function`](https://idiosyncratic-ruby.com/8-self-improvement.html#modulefunction), [`extend self`](https://idiosyncratic-ruby.com/8-self-improvement.html#modulefunction).

```ruby
module TwoFer
  module_function

  def two_fer(name = 'you')
    format('One for %<name>s, one for me.', name: name)
  end
end
```
Solutions can also use string templates with [`sprintf`](https://ruby-doc.org/core/Kernel.html#method-i-sprintf) or [`%`](https://ruby-doc.org/core-2.5.3/String.html#method-i-25):

```ruby
class TwoFer

  class << self
    def two_fer(name = 'you')
      'One for %s, one for me.' % name
    end
  end
end
```

## Common suggestions
- If a student uses a conditional, suggest a default value for the argument `name`.
- If a student sets the default value of `name` to `nil`, ask if there is something they could do with the default value to avoid the conditional statement, making their code simpler.
- If the code doesn't pass the tests, ask them if they need help with running the tests.
- Style suggestions based on community conventions:
  - Remove explicit `return` ([no-explicit-return](https://github.com/rubocop-hq/ruby-style-guide#no-explicit-return))
  - Use `def` with parentheses, because of the [parameter (method-parens)](https://github.com/rubocop-hq/ruby-style-guide#method-parens).
  - Use indentation of [2-spaces (spaces-indentation)](https://github.com/rubocop-hq/ruby-style-guide#spaces-indentation)).

## Talking points
- [Implicit returns](https://franzejr.github.io/best-ruby/idiomatic_ruby/implicit_return.html)
- Default values
- [String interpolation](http://ruby-for-beginners.rubymonstas.org/bonus/string_interpolation.html), but a student may also use string templates via `format`, `sprintf` or `%`. You may mention the alternative technique (templates when interpolation is used, and vice versa), always prefer either over string concatination.
- Style preferences based on [community style guide via rubocop](https://github.com/rubocop-hq/ruby-style-guide): This exercise is a good opportunity to talk about style conventions like indentation, parameter parenthesis in method declarations and removing redundant comments. Given the place in the curriculum, it may be worth not going too deep, and to not addressing points that are controversial or personal preference.

## Mentoring notes
- A friendly standard answer about how this can be done in one line, and a 'hint: use a different default value' to get rid of the conditionals, will be all you need for maybe 90% of the submissions.

