### Reasonable solutions

Using `uniq`
```ruby
def isogram?(string)
  letters = string.downcase.scan(/[[:alpha:]]/)
  letters.uniq.length == letters.length
end
```

Using `Set`'s `add?`
```ruby
require "set"

class Isogram
  def self.isogram?(text)
    seen_before = Set.new
    text.downcase.
      scan(/[[:alpha:]]/).
      all? { |l| seen_before.add?(l) }
  end
end
```

### Common suggestions
- Suggest using `scan` rather than `gsub` as it removes the need to break the string into chars. Links to https://ruby-doc.org/core-2.2.0/String.html#method-i-scan

### Talking points
- Comparing lengths (`letters.uniq.length == letters.length`) is **marginally** quicker than comparing letters (`letters.uniq == letters`) but its more code. Which is better?
