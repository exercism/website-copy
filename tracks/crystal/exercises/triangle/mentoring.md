# Mentoring

## Reasonable Solutions

This problem has relatively few variations.

```crystal
class Triangle
  getter sides : Array(Int32)
  property? valid : Bool
  def initialize(sides)
    @sides = sides.sort
    @valid = sides[2] < sides[1] + sides[0]
  end

  def equilateral?
    valid? && sides.uniq.size == 1
  end

  def isoseles?
    valid? && sides.uniq.size <= 2
  end

  def scalene?
    valid? && sides.uniq.size == 3
  end
end
```
Some people will use:
```crystal
def equilateral?
  valid && sides.all?(sides[0])
end
```
This is fine.
Testing all permutations for the triangle inequality should be unnecessary, unless the input might contain negative numbers.
```crystal
@valid = sides.permutations.all? { |s1, s2, s3| s2 < s1 + s3 }
```

## Structure

The structure here is dictated by the problem, for the most part. A validation method can be defined instead of using a stored property. Using `!isoseles? && !equilateral?` in the `scalene?` method is perhaps a little more legible, but tests the array more than once. 

## Style

Using `property?` to generate a `valid?` accessor is convenient. It's probably best to declare the type of `@sides` either in the getter or in the signature for `initialize`.
