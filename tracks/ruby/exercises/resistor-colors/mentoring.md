Resistor Colors is a side exercise, unlocked by Hello World

### New Concepts
Array, Array#index, `map`, Constant, chaining methods

### Minimal solution for approval
```ruby

class ResistorColors

  COLOR_CODES = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]
  
  def self.value(colors)
    colors.map { |color| COLOR_CODES.index(color) }.join.to_i
  end

end

```

### General
This is the very first Array exercise, and the first loop. Introducing `map` is key in this exercise. At this point in the track, there's no need to address `.freeze`. 

### Talking points 
- _`%w` notation_: for arrays of strings. Link to [styleguide](https://github.com/rubocop-hq/ruby-style-guide#percent-w)
- _chaining methods_ after a block (especially when people use a local variable for `join.to_i`
- _`each` vs `map`_: this explains the difference: [each vs map](https://learn.onemonth.com/ruby-tutorial-map-vs-each/)
- _variable vs constant_: this article explains just that: [var vs constant](https://ruby-doc.org/docs/ruby-doc-bundle/Tutorial/part_01/variables.html) 

### Changelog
First introduced 2019 Mar 10 
