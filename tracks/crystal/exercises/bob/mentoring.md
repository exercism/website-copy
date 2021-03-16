# Mentoring

### Reasonable Solutions

There are two general approaches, either using regular expressions or `String` methods.

```crystal
class Bob
  getter comment
  
  def self.hey(comment : String) : String
    self.new(comment).response
  end

  def initialize(@comment : String) : String
  end

  def response : String
    if shouting? && questioning?
      "Calm down, I know what I'm doing!"
    elsif shouting?
      "Whoa, chill out!"
    elsif questioning?
      "Sure."
    elsif silent?
      "Fine. Be that way!"
    else
      "Whatever."
    end
  end

  private def shouting?
    comment.each_char.any?(&.ascii_letter?) && comment == comment.upcase
  end

  private def questioning?
    comment.ends_with?("?")
  end

  private def silent?
    comment.blank?
  end
end
```

```crystal
module Bob
  SHOUTING = "\\A(?=.*[A-Z])(?!.*[a-z])"

  QUESTIONING = ".*\\?\\z"

  SILENT = "\\A\\s*\\z"

  def self.hey(comment : String) : String
    case comment
      when %r{#{SHOUTING + QUESTIONING}}
        "Calm down, I know what I'm doing!"
      when %r{#{SHOUTING}}
        "Whoa, chill out!"
      when %r{#{QUESTIONING}}
        "Sure."
      when %r{#{SILENT}}
        "Fine. Be that way!"
      else
        "Whatever."
      end
  end
end
```

### Common Suggestions

A `case` statement is probably recommended over `if`/`elsif`. As with many Exercism exercises, using an instantiated class is not a strict requirement, but probably useful if any helper methods (e.g. `shouting?`) are defined.

Regular expressions are powerful but illegible. If used, they should be assigned to constants.
It's not required that methods declare what type they accept and return, but the larger the project and more complicated the code, the more this becomes a good idea.
