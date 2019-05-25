Resistor Color Duo is a side exercise, unlocked by Hello World (meaning this _may_ be the first time they get mentoring!). 

### New Concepts
Array, Array#index, `map`, Constant, chaining methods

### Minimal solution for approval
```ruby

class ResistorColorDuo

  COLOR_CODES = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]

  def self.value(colors)
    colors.map { |color| COLOR_CODES.index(color) }.join.to_i
  end

end

```

### General
This is the very first Array exercise, and the first loop. Introducing `map` is key in this exercise. You, dear mentor, are totally right that using a hash would be a better solution, because it makes the relation between the color and it's value explicit. But we really want people to know how to work with arrays before we ask them to work with hashes. (That will be taken care of later on in the track.) If a student _starts_ with a hash themselves, then by all means go with the hash.

### Talking points
- _`%w` notation_: for arrays of strings. Link to [styleguide](https://github.com/rubocop-hq/ruby-style-guide#percent-w)
- _chaining methods_ after a block (especially when people use a local variable for `join.to_i`
- _`each` vs `map`_: this explains the difference: [each vs map](https://learn.onemonth.com/ruby-tutorial-map-vs-each/)
- _variable vs constant_: this article explains just that: [var vs constant](https://ruby-doc.org/docs/ruby-doc-bundle/Tutorial/part_01/variables.html)
- _freeze_: this post has exactly the right level of information: [freeze](https://freelancing-gods.com/2017/07/27/an-introduction-to-frozen-string-literals.html); no need to dive deeper into (im)mutability.


### Changelog

2019 Apr 06 - Renamed to Resistor Color Duo  
2019 Mar 10 - First introduced
