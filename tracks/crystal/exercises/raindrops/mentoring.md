# Mentoring

## Reasonable Solutions

In basic terms, there is only one correct algorithm. How to apply that is the subject of this exercise. Most will initially write:

```crystal
module Raindrops
  def self.drops(number)
    sounds = ""
    sounds += "Pling" if number.divisible_by?(3)
    sounds += "Plang" if number.divisible_by?(5)
    sounds += "Plong" if number.divisible_by?(7)
    sounds.empty? ? number.to_s : sounds
  end
end
```

There are arguments for writing low-level-of-abstraction code. It's simple to understand, and usually offers good performance. However, when we are writing code, we should prefer to use the highest level of abstraction which is practical, and in particular, we should seek to [avoid repetition in code][DRY]. Repetitive tasks are what the computer is for. It's always possible (and almost always preferable) to eliminate code repetition by raising the level of abstraction. Students should be guided to write the following:

```crystal
module Raindrops
  RAIN_SOUNDS = {
    3 => "Pling",
    5 => "Plang",
    7 => "Plong"
  }

  def self.drops(number)
    sounds = RAIN_SOUNDS.select do |factor, _|
      number.divisible_by?(factor)
    end
    sounds.empty? ? number.to_s : sounds.values.join
  end
end
```
It is also possible to use `each_with_object("")`, but using conditionals in loops is lower down the abstraction ladder than using a method that embeds that conditional within itself, and mutating strings is rarely preferable.

## Common Suggestions
Style

Prefer `divisible_by?` to `modulo(factor).zero?`, and prefer either over `number % factor == 0`

[DRY]: https://deviq.com/don-t-repeat-yourself/
