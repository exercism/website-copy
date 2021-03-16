# Mentoring

## Reasonable Solutions

There are a number of equally-good choices for iteration in this problem, but there is no reason to use anything other than `count` to determine the number of differences between the strings (`reduce` or `select ... size` are possible, but the goal is to use `count`).

```crystal
module Hamming
  def self.compute(strand, other)
    raise ArgumentError.new unless strand.size == other.size
    strand.chars.zip(other.chars).count do |base, other|
      base != other
    end
  end
end
```
```crystal
module Hamming
  def self.compute(strand, other)
    raise ArgumentError.new unless strand.size == other.size
    (0...strand.size).count do |index|
      strand[index] != other[index]
    end
  end
end
```
```crystal
module Hamming
  def self.compute(strand, other)
    raise ArgumentError.new unless strand.size == other.size
    strand.each_char.with_index.count do |base, index|
      base != other[index]
    end
  end
end
```

There is not a large difference in performance for any of the above options. In particular, `zip` is not markedly slower, and can be faster than using explicit indexes (which may surprise students used to other languages). It's also possible to accept the arguments as a `Tuple`, but while this is a valid solution, and may (arguably) be worth discussing, it should probably be considered a "novelty" solution rather than something mentors should guide students to.

```crystal
module Hamming
  def self.compute(*strands)
    strands.map(&.chars)
      .to_a
      .transpose
      .count {|(first, second)| first != second }
  rescue IndexError
    raise ArgumentError.new "The strands are not equal in length."
  end
end
```

## Structure

It is possible to create an instantiable class here, but not necessary. It seems unlikely that in real-world code this method would either use an instantiable object, or organize its functions into more than one method. However, there's nothing wrong with either the student or the mentor choosing to explore those ideas.

## Style

There are not any obviously correct choices for variable names for this problem. Students should prefer using `unless` to `if` in the "guard clause"
