# Mentoring

## Reasonable Solutions

This is a relatively straightforward problem with some minor variations. The "standard" solution is:
```crystal
class Series
  def initialize(sequence)
    @sequence = sequence.each_char.map(&.to_i64)
  end

  def largest_product(span)
    raise ArgumentError.new unless span < @sequence.size
    return 1 if span.zero?
    @sequence.each_cons(span)
      .map(&.product)
      .max
  end
end
```
It's also possible to use `reduce`:
```crystal
def largest_product(length)
  raise ArgumentError.new unless @sequence < @sequence.size
  return 1 if length.zero?
  @sequence.each_cons(length, true).reduce(0) do |max, subset|
    product = subset.product
    product > max ? product : max
  end
end
```
`reduce` is a slightly lower level of abstraction: it can be used to write `max`, and indeed most other `Enumerable` methods. As a lower-level-of-abstraction method, it is more verbose, and does not embed its function into its name. In this case, it does offer a slight performance advantage. Either solution is acceptable. It's also possible to use iterators other than `each_cons`, but there are few reasons to do so.

## Structure

A class is a requirement. Since the idea of an initializer is to make the class ready to use, it's reasonable to convert the sequence to integers in the initializer.

## Style

Prefer `zero?` to `== 0`, and `unless` to `if` in the guard clauses. As usual, variable names should be dictionary words.
