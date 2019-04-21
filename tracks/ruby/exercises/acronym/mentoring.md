_Acronym_ is meant for practicing with `String#scan`. 

## Reasonable Solutions

```ruby
module Acronym
  def self.abbreviate(fullname)
    fullname.scan(/\b[a-zA-Z]/).join.upcase
  end
end
```
with variations for the regex (see below).

## Common suggestions
* Most first submissions split the phrase into words with `String#split`: 
  ```ruby
  phrase.split(/[ -]/)
  ```
  followed by operations to find the first letters.
  Variation: first `gsub` or `tr` the non-space delimiters, then `split`.
  
In all these cases: it's recommended to suggest the `String#scan` method and, because the exercise is not about Regular Expressions, give them also the RegEx (`/\b[a-zA-Z]/`). (At this point in the track, it's more about experiencing the strengths of Ruby's built-in methods than making them find them. There's ample opportunity for research later on in the track.)   

## Talking points
* If the solution uses Class instead of Module: that's totally acceptable at this stage. No reason to discuss.
* Because of the regex needed for `split`, `scan` is in this exercise (marginally) faster.
* It can be hard to catch all the possible delimiters. 
* `upcasing` the whole string is (10% ?) slower than `upcasing` the acronym only. 
* Store the regex in a constant or a variable, mostly so it can be named. 

## Passing Regular Expressions
`/\b[a-zA-Z]/` # only returns first letters, not `_` (but completely ignores words starting with `_`)

`\b[[:alpha:]]/` # same

`/\b\w/` # close enough; but it would return `_` as a first 'word character'

`/\b[[:word]]/` # same 

`/(?<!\p{Alpha})\p{Alpha}/` # finds first letters even with underscores in front of them (Note: we don't have tests for this case. The only reason we test for `'` is to ensure that `split` is not a equally good choice.)
