# Mentoring

Resistor Color Duo is the first core exercise after TwoFer.

## New Concepts

`Array`, `Array#index`, `map`, or `Hash`, `Hash#[]`; Constant, chaining methods

## Minimal solution for approval

- Using either an array of color names and reading the index as the value, or a hash of colors and values
- Extracting the values in a `constant`, outside of the method
- Two possible approaches:
  - Iterating over the color names, and join them together to compose a 2-digit number
  - Acknowledging the position of each band, by treating the first color as 'tens' and the second as 'ones'

```ruby
class ResistorColorDuo
  COLOR_CODES = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"].freeze

  # The 'join' approach
  def self.value(colors)
    colors.first(2).map { |color| COLOR_CODES.index(color) }.join.to_i
  end

  # The 'positional' approach
  def self.value(colors)
    tens, ones = colors
    COLORS.index(tens) * 10 + COLORS.index(ones)
  end
end

# with a hash instead of an array
COLOR_CODES[colors[0]] * 10 + COLOR_CODES[colors[1]]

# or
colors.take(2).map { |color| COLOR_CODES[color] }.join.to_i
```

## Reasonable Variants

```ruby
# and `&` syntax
colors.take(2).map(&COLOR_CODES).join.to_i
```

Plus:

- Using a class or a module (no reason to discuss).
- The color names as strings or symbols.

## General

Both array and hash have their pros and cons.
A hash makes the mapping more explicit, while an array seems to better reflect the fact that a color band has a position plus a numerical value (the tens and ones).
Some mentors have a strong preference for one over the other, but it is recommended to go with the solution the student starts with.

Same for the general approach, `join` or `positional approach`: go with the solution the student starts with.

Fun fact: Resistor Color Trio will actually use the third color, and will be a more appropriate moment to talk about the pros and cons of both the data structure and the general approach.

## Talking points

- _string interpolation_ : if the student uses string interpolation to compose the value, challenge them to solve it with `map` and `join`.
  Approve if they do not want to do the challenge.
- _`%w` notation_: for [arrays of strings][style guide#percent literal].
- _chaining methods_ after a block (especially when people use a local variable for `join.to_i`
- _`each` vs `map`_: this explains the difference: [each vs map][each vs map]
- _variable vs constant_: this article explains just that: [var vs constant][var vs constant]
- _freeze_: this post has exactly the right level of information: [freeze][freeze]; no need to dive deeper into (im)mutability.

## Changelog

- 2021 Nov - Markdown adjustment to style guide (sentences and links)
- 2019 Apr - Renamed to Resistor Color Duo
- 2019 Aug - Version 2.1 introduces a new test: an input of 3 colors should still return a 2 digit number, ignoring the third color
- 2019 Jul - Changed from side to core exercise
- 2019 Mar - First introduced

[each vs map]: https://learn.onemonth.com/ruby-tutorial-map-vs-each/
[freeze]: https://freelancing-gods.com/2017/07/27/an-introduction-to-frozen-string-literals.html
[style guide#percent literal]: https://rubystyle.guide/#percent-literals
[var vs constant]: https://ruby-doc.org/docs/ruby-doc-bundle/Tutorial/part_01/variables.html
