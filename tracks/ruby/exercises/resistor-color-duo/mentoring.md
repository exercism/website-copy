Resistor Color Duo is a side exercise, unlocked by Hello World (meaning this _may_ be the first time they get mentoring!). 

### New Concepts

`Array`, `Array#index`, `map`, Constant, chaining methods

### Minimal solution for approval

* using `map` to iterate over the array of colors
* extracting the values in a `constant`, outside of the method

```ruby

class ResistorColorDuo

  COLOR_CODES = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"].freeze

  def self.value(colors)
    colors.map { |color| COLOR_CODES.index(color) }.join.to_i
  end

end

```

### Reasonable Variants

```ruby
# with a hash instead of an array 
COLOR_CODES.fetch_values(*colors).join.to_i

# and &Parameter
colors.map(&COLOR_CODES).join.to_i

# or a hash with symbols
colors.map { |color| COLOR_CODES[color.to_sym] }.join.to_i
```

- Using a class or a module (no reason to discuss). 
- Multiplying the first value and adding the second one.     

### General

This is the very first Array exercise, and the first loop. Introducing `map` is key in this exercise. 

You, dear mentor, are totally right that using a hash would be a better solution, because it makes the relation between the color and its value explicit. But we really want people to know how to work with arrays before we ask them to work with hashes. (That will be taken care of later on in the track.) If a student _starts_ with a hash themselves, then by all means go with the hash.

### Talking points
- _string interpolation_ : if the student uses string interpolation to compose the value, challenge them to solve it with `map` and `join`. Approve if they don't want to do the challenge. 
- _`%w` notation_: for arrays of strings. Link to [styleguide](https://github.com/rubocop-hq/ruby-style-guide#percent-w)
- _chaining methods_ after a block (especially when people use a local variable for `join.to_i`
- _`each` vs `map`_: this explains the difference: [each vs map](https://learn.onemonth.com/ruby-tutorial-map-vs-each/)
- _variable vs constant_: this article explains just that: [var vs constant](https://ruby-doc.org/docs/ruby-doc-bundle/Tutorial/part_01/variables.html)
- _freeze_: this post has exactly the right level of information: [freeze](https://freelancing-gods.com/2017/07/27/an-introduction-to-frozen-string-literals.html); no need to dive deeper into (im)mutability.


### Changelog

2019 Apr 06 - Renamed to Resistor Color Duo

2019 Mar 10 - First introduced
