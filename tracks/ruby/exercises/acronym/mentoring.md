# Mentoring

_Acronym_ is meant for practicing with `String#scan`.

## Reasonable Solutions

```ruby
module Acronym
  def self.abbreviate(full_name)
    full_name.scan(/\b[a-zA-Z]/).join.upcase
  end
end
```

with variations for the regex (see below).

## Common suggestions

- Most first submissions split the phrase into words with `String#split`:

  ```ruby
  phrase.split(/[ -]/)
  ```

  followed by operations to find the first letters.
  Variation: first `gsub` or `tr` the non-space delimiters, then `split`.

In all these cases: it is recommended to suggest the `String#scan` method and, because the exercise is not about Regular Expressions, give them also the RegEx (`/\b[a-zA-Z]/`).
(At this point in the track, it is more about experiencing the strengths of Ruby's built-in methods than making them find them.
There's ample opportunity for research later on in the track.)

## Talking points

- `Class vs Module`: If the solution uses Class instead of Module: that's totally acceptable at this stage.
  No reason to discuss.
- Because of the regex needed for `split`, `scan` is in this exercise (marginally) faster.
- It can be hard to catch all the possible delimiters.
- `upcasing` the whole string is (10% ?) slower than `upcasing` the acronym only.
- Store the regex in a constant or a variable, mostly so it can be named.
- `join("")`: The `("")` after `join` can be omitted, because it is the default for `join`.

## Mentoring strategy

- When they start with `split`, with or without `tr` or `gsub`, and `map` to `upcase`: start with pointing them to `scan`, name what it accomplished afterwards:
  1. (first comment)
     Using split works, but it forces you to focus on the delimiters (space, -).
     Ruby has `String#scan`.
     With `scan` and a regex (Regular Expression), you can catch the parts you need.
     For instance, `scan` with the regex `/\b[a-zA-Z]/` will catch 'word boundaries' (space, - and more) followed by a word character.
     I use "www.rubular.com" whenever I want to check a regex.
  2. (after using `scan`) You just discovered one of the strengths of Ruby: we can extract certain parts of a string into an array in only one or two operations most of the time. :-)
     With `scan`, you avoid the multiple iteration. You also got rid of the intermediate variable 'xxx', that you needed to track stuff in your loop. That's called the Accumulator pattern. In general, eliminating the extra variable is considered best practice in Ruby.

## Passing Regular Expressions

- `/\b[a-zA-Z]/` # only returns first letters, not `_` (but completely ignores words starting with `_`)
- `\b[[:alpha:]]/` # same
- `/\b\w/` # close enough; but it would return `_` as a first 'word character'
- `/\b[[:word:]]/` # same
- `/(?<!\p{Alpha})\p{Alpha}/` # finds first letters even with underscores in front of them (Note: we do not have tests for this case. The only reason we test for `'` is to ensure that `split` is not a equally good choice.)
- `/(?:\b|_)([[:alpha:]])/` # finds first letters even with underscores before and throughout, e.g., ""_Ruby_On_Rails_" as "ROR" and I10N as "I"

## Changelog

- 2021 Nov - Markdown adjustment to style guide (sentences and links)
