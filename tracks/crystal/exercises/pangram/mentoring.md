# Mentoring

## Reasonable Solutions

There are lots of ways to solve this one. Methods that operate on the whole collection are preferred to iterative methods.

```crystal
module Pangram
  ALPHABET = ('a'..'z').to_a
  def self.pangram?(phrase)
    (ALPHABET - phrase.downcase.chars).empty?
  end
end
```
```crystal
module Pangram
  ALPHABET = ('a'..'z').to_a
  def self.pangram?(phrase)
    ALPHABET & phrase.downcase.chars == ALPHABET
  end
end
```
```crystal
module Pangram
  ALPHABET = Set.new('a'..'z')
  def self.pangram?(phrase)
    ALPHABET.subset? Set.new(phrase.downcase.chars)
  end
end
```

**Iterative:**

```crystal
class Pangram
  ALPHABET = ('a'..'z')

  getter chars

  def self.pangram?(phrase)
    self.new(phrase).valid?
  end

  def initialize(phrase)
    @chars = phrase.downcase.chars
  end

  def valid?
    ALPHABET.all?(&->chars.includes?(Char))
  end
end
```

## Common Suggestions

The exercise does not require the instantiation of any objects, so this should be considered optional. However, this problem does divide itself into two operations, one of which is transforming the input into a usable form. There is a symmetry between that idea and the idea that initializers prepare objects for use. On the other hand, it's difficult to see other purposes for this instantiated object, and it does make the code longer. When no clear arguments present themselves in either direction, the matter may be left to the judgement of the mentor and the student, but a discussion of the issue is probably worthwhile.

This problem requires some representation of the alphabet, either as a `Set`, `Range`, or `Array`. This should be stored as a constant. Iterative solutions probably lend themselves to the use of `&->`, as shown above.
