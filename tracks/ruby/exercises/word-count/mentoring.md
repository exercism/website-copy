# Mentoring

## New Concepts

- Hash (it is new here because Robot Name has been removed as a core exercise)
- constant
- `each_with_object`: avoiding a separate accumulator variable

## Minimal solution for approval

```ruby
class WordCount
  WORD_REGEX = /\b[\w']+\b/

  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words.each_with_object(Hash.new(0)) do |word, count|
      count[word] += 1
    end
  end

  private

  def words
    @phrase.downcase.scan(WORD_REGEX)
  end
end
```

## Reasonable Variants

- `reduce`/`inject` for counting: see [better-hash injection using each with object][better-hash-injection] why to prefer each_with_object, especially as an after-approval challenge.
- An exceptionally nice solution uses `group_by(&:itself)`, and the `transform_values` method introduced in Ruby 2.4

```ruby
  def word_count
    words.group_by(&:itself).transform_values(&:count)
  end
```

Note that `Symbol#to_proc` is a new concept in the track.

## General

- This is the first exercise where students practice with avoiding the Accumulator Pattern (with a counter variable)!
  It is an important goal of this exercise.
- Solutions with `each`, `for` or others are not considered approvable (at least not in a first submission and/or without addressing it).
- The regular expression gets complicated in the last test, where it should catch both `"large"` and `'large'` `=> { large: 2 }`.
  As long as they got something that catches a word with or without `'`, it is fine to give away the last step for free.
  The [rubular.com][rubular] site specifically uses the Ruby regular expression
  engine.

## Talking points

- `inject`/`reduce`: see note under Reasonable Variants.
- Extracting the preparation of the input into a separate (private) method.
- Intermediate steps to strip quotes: One strategy people use to catch quoted words is an intermediate step like 'strip_quotes'. Suggest to solve it within the regular expression.
- Constant: Storing the regular expression in a Constant.
- The goal of separating the preparing of the input from the processing itself.
- Do's and don'ts in initializers.
- Can the [Enumerable#tally][enumerable-tally] method introduced in Ruby 2.7 do the work for us

Passing regular expressions:

- `/\b[\w']+\b/`
- `/\b[[:alnum:]']+\b/`
- `/\b[[:word:]']+\b/`

## Changelog

- 2021 Nov - Markdown adjustment to style guide (sentences and links)

[better-hash-injection]: https://technology.customink.com/blog/2014/10/14/better-hash-injection-using-each-with-object/
[enumerable-tally]: https://ruby-doc.org/core-2.7.2/Enumerable.html#method-i-tally
[rubular]: http://www.rubular.com/
