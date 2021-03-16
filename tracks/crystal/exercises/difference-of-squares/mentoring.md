# Mentoring

## Reasonable Solutions

There are two approaches, iterative and non-iterative. Students are highly likely to use the iterative approach first, and should be encouraged (but **not** required) to explore the mathematical approach. On the other hand, if the student arrives at the mathematical solution first, there may be a presumption that they already understand iteration, and the mentor may wish to explore the iterative approach in discussion, or not at all, at their discretion.

```crystal
module Squares
  extend self
  def square_of_sum(ordinal)
    1.to(ordinal).sum ** 2
  end

  def sum_of_squares(ordinal)
    1.to(ordinal).sum(&.**(2))
  end

  def difference_of_squares(ordinal)
    square_of_sum(ordinal) - sum_of_squares(ordinal)
  end
end
```

```crystal
module Squares
  extend self
  def square_of_sum(ordinal)
    ((ordinal + 1) * ordinal / 2) ** 2
  end

  def sum_of_squares(ordinal)
    (ordinal * (ordinal + 1) * (2 * ordinal + 1)) / 6
  end

  def difference_of_squares(ordinal)
    square_of_sum(ordinal) - sum_of_squares(ordinal)
  end
end
```
Either approach should be acceptable for approval.
The order of operations in `difference_of_squares` is significant: it's relatively common to reverse them and use `abs` to obtain a positive result. This has no advantages.

## Structure

The structure of this problem is dictated by the way it is called: there is no need or purpose for an instantiable class here. Thus, `Squares` should either be a module or a `Struct` (the Crystal documentation recommends structs for performance reasons, but this should be a talking point rather than a requirement). It's possible to define a `square` method, either on the `Squares` module or on `Int32`, and students should not necessarily be discouraged from doing so, but there isn't really a need, and mentors should feel free not to mention this.

## Style

Crystal has a number of ways to create the appropriate `Range` here, using `upto`, `downto`, `to`, or a `Range` literal. There is no reason to prefer any particular method. In the `sum_of_squares` method, students using `map(&.**(2)).sum` should be advised that `sum` accepts a block argument. Students may prefer to avoid the construct `&.**(2)` as being less legible than an explicit block, and there's nothing wrong with that, but it should be noted that `&.` is a normal and common Crystal idiom. As ever, &ldquo;use makes master&rdquo;.

A great many students will use `n` or `num` as a variable name. On the one hand, this is relatively traditional in computer science. On the other hand, there is an argument that variables should be dictionary words, so that readers who are unfamiliar with the English language are able to look up the word in question. This may be a talking point, at the mentor's discretion.
