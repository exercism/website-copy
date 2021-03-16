# Mentoring

## Reasonable Solutions

There are technically two ways to do this, but only one is useful.

```crystal
module Year
  def self.leap?(year : Int32) : Bool
    year.divisible_by?(4) && (!year.divisible_by?(100) || year.divisible_by?(400))
  end
end
```
```crystal
module Year
  def self.leap?(year : Int32) : Bool
    year.divisible_by?(year.divisible_by?(25) ? 16 : 4)
  end
end
```
The second solution is mathematically equivalent, but totally obscures the meaning and intent of the code. It can be a talking point for the mathematically inclined, and it is acceptable as a solution, but students should be cautioned against using this sort of "clever" code in real-world applications.

## Structure

Creating an object (or any helper methods) solves no problems here. Since nothing will be instantiated, a `Struct` or `Module` would be preferable to a `Class`. The Crystal documentation suggests using structs when possible for performance reasons, but this is not a requirement.

## Style

Using `year % 4 == 0` is less preferable than `year.modulo(4).zero?`, and neither improve on `year.divisible_by?(4)`. 
