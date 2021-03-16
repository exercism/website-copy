# Mentoring

New concepts: Array query methods (+ chaining methods), instantiating a class, writing and calling(!) a getter method or `attr_reader`.

### Minimal solution for approval

```ruby
class HighScores
  def initialize(scores)
    @scores = scores
  end

  def scores
    @scores
  end

  def personal_best
    scores.max
  end

  def latest
    scores.last
  end

  def personal_top_three
    scores.max(3)
  end

  def latest_is_personal_best?
    latest == personal_best
  end
end
```

### Reasonable variants

 - Using `attr_reader :scores` instead of the getter method `scores` is better, but no need to point them to `attr_reader` if they write the method `scores`.

### General

- The instructions point to a beginner friendly explanation of instantiating a class: [Ruby for Beginners](http://ruby-for-beginners.rubymonstas.org/writing_classes/initializers.html). They also point to the Ruby docs for [Array](https://ruby-doc.org/core/Array.html).
- `sort.reverse` is not very performant, but no need to mention performance.  However, it is important that students know how to find the methods that are available.  If this is used, perhaps `take` is a good method to use, but `max` is better, as it does selection step for us.

### Talking points

- `@scores` vs `scores`: This is the most important issue in this exercise. Beginners may _write_ the getter method/`attr_reader`, but _call_ the instance variable `@scores` still. This link explains some of the advantages of using the getter method internally in the class instead of directly referencing the instance variable: [LaunchSchool: accessor_methods](https://launchschool.com/books/oo_ruby/read/classes_and_objects_part1#accessormethodsinaction). It's recommended to link to this or your favorite explanation, instead of typing the solution for them.
- `latest_is_personal_best?`: this predicate method should use the existing methods, and implicitly return true or false. For new programmers it may be helpful to ask what they think the question mark indicates.
- `scores.max(3)`: `Array#max` [takes an argument](https://ruby-doc.org/core/Array.html#method-i-max).
- `Array#[]`: Most submissions retrieve the `personal_top_three` values with the `Array#[]` method, which is harder to read than the convenience methods that Ruby offers. `Array#take(3)` or `Array#first(3)` win in readability. And `Array#max(3)` doesn't even need the sorting-and-reverting steps.

### Changelog

- Version 5 added a boolean/predicate method `latest_is_personal_best?` (See https://github.com/exercism/problem-specifications/pull/1564)
- Version 3/4 changed method names "personal_top" -> "personal_top_three" and removed the "report" method. (See related Mentor Notes [here](https://github.com/exercism/website-copy/blob/aa66a176756313687baf214bbb051e1c3fc0f832/tracks/ruby/exercises/high-scores/mentoring.md).)
- Version 2 changed method names "highest" -> "personal_best", "top" -> "personal_top".

