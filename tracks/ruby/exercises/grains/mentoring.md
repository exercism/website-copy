### Intro
TwoFer -> Hamming -> RainDrops -> Difference of Squares -> **Grains** -> Scrabble Score 

The instructions for the students suggest(!) that the first solution would use an iteration, and that the next step would be optimizing (with maths) for performance and/or readability.
At this point, students should have used 'basic' and 'advanced' Enumberable methods for iterations in previous exercises (core: Hamming, Difference of Squares, side: Series).  


### Reasonable solutions

The use of a custom exception, the choice of variable names that relate to the story not the maths (`position` rather than `number`), and the use of `cover?` all make this an excellent solution.

```ruby
module Grains
  SQUARES = (1..64)

  def self.square(position)
    raise BoardPositionError unless SQUARES.cover? position
    2 ** (position - 1)
  end

  def self.total
    square(SQUARES.max) * 2 - 1
  end
end

class BoardPositionError < ArgumentError
  def initialize(message = "This position doesn't exist on this board")
    super
  end
end
```

### Common suggestions 
- With a compound conditional `(< 1 || > 64)` -> Extract the compound conditional in a separate method and/or use `between?`.
- With a range, like in the example -> `cover?` is a great and fast way to check if an object is inside the range.

- With a non-maths solution, on `total` -> `inject` or `reduce` are sub-optimal, suggest `sum` (Ruby 2.4+)
- If the solution uses iteration on the `square` method instead of using exponentiation, consider challenging the student to write out the sequence of grains and ask them if they see a pattern that may point to a simpler solution (1, 2, 4, 8, ...).

- If the solution uses `64` in multiple places, suggest extracting the number to a constant. [This link](https://refactoring.guru/replace-magic-number-with-symbolic-constant) can be a good resource to share.


### Talking points
- Naming things is so relevant for this exercise. What does the magic number 64 means? Parameter name: is it a 'number' or...?
- Following the above, perhaps discuss the concept of [magic numbers](https://refactoring.guru/replace-magic-number-with-symbolic-constant) and why we tend to replace them by constants or similar named constructs.
- Constants (and naming them).
