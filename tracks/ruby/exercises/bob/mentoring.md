# Mentoring

The key to this exercise is to look for patterns in a string, and extracting the specific criteria in order to make return the correct response.
Most solutions look for `yelling` and `asking` criteria.

## Resonable Solutions

### Using String Methods

```ruby
module Bob

  def self.hey(remark)
    remark = remark.strip
    question = remark.end_with?('?')
    yelling = remark == remark.upcase && remark != remark.downcase

    if remark.empty?
      'Fine. Be that way!'
    elsif yelling && question
      "Calm down, I know what I'm doing!"
    elsif yelling
      'Whoa, chill out!'
    elsif question
      'Sure.'
    else
      'Whatever.'
    end
  end

end
```

### Using Regular Expressions

```ruby
module Bob

  SILENCE = /\A\s*\z/
  ASKING = /\?\s*\z/
  SHOUTING = /\A[^A-Za-z]*[A-Z]+(?:[^a-z]*)\z/


  def self.hey(input)
    case
    when silence?(input)
      'Fine. Be that way!'
    when asking?(input) && shouting?(input)
      "Calm down, I know what I'm doing!"
    when asking?(input)
      'Sure.'
    when shouting?(input)
      'Whoa, chill out!'
    else
      'Whatever.'
    end
  end

  class << self
    protected
    def silence?(input)
      SILENCE.match?(input)
    end

    def shouting?(input)
      SHOUTING.match?(input)
    end

    def asking?(input)
      ASKING.match?(input)
    end
  end
end
```

## Common Suggestions

### Predicate Methods

The names of predicate methods (methods that return a boolean value) should end in a question mark (i.e. Array#empty?).

Resources about style:
- https://rubystyle.guide/#bool-methods-qmark
- https://rubystyle.guide/#bool-methods-prefix

### Using `end_with?`

* If the student is using indicies to check for a question mark at the end of the input, guide them towards Ruby's `String#end_with?` method.

### Usage of Regular Expressions

Regular expressions are powerful, but can be illegible.
While regex is common in Ruby code, if the student is having a hard time understanding regex it may be better to guide them toward a solution that uses simpler String methods.
