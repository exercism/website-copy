# Accumulate

This exercise is asking you to re-implement `Array#map`. The goal is to get a
feel for what's happening under the hood.

## Reasonable Solutions

There are 4 general classes of solutions that fall in a matrix
`(functional | imperative) X ( high-level | low-level)`.

```ruby
# High-level functional

class Array
  def accumulate
    reduce([]) { |arr, item| arr.append(yield item) }
  end
end
```

```ruby
# High-level imperative

class Array
  def accumulate
    result = []
    each { |item| result << (yield item) }
    result
  end
end
```

```ruby
# Low-level functional
# recursion

class Array
  def accumulate(accumulator = [], &block)
    if empty?
      accumulator
    else
      first, *rest = self
      rest.accumulate(accumulator.append(yield first), &block)
    end
  end
end
```

```ruby
# Low-level imperative
# for loops

class Array
  def accumulate
    result = []
    for item in self do
      result << (yield item)
    end
    result
  end
end
```

### Talking Points
- Block syntax (`yield` vs `block.call`)
- All `Enumerable` methods can be implemented in terms of `each` or `reduce`
- High vs low-level approaches
- Functional vs imperative

### Restrictions

Note that the student should _not_ use `Array#map` here as that defeats the
purpose of this exercise. From the instructions:

> Keep your hands off that collect/map/fmap/whatchamacallit functionality
> provided by your standard library! Solve this one yourself using other basic
> tools instead.
