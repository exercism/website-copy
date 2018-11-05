# Acronym
TwoFer -> **Acronym** -> Isogram -> Hamming -> ...

_Acronym_ is promoted to a core exercise, the first after _TwoFer_. It's meant to introduce `String#scan`.

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
  , followed by operations to find the first letters.
  Variation: first `gsub` or `tr` the non-space delimiters, then `split`
  
In all these cases: point to String#scan.   
* The first use of `scan` mostly is a scan for full words. That's a perfect moment to show the power of `scan`: 
when it returns the first letters only, it will save a few operations.  
* As this exercise is not about Regular Expressions, it's recommended to 
give the regex away for free, especially if they already found `scan(/\w+/)`

## Talking points
* If the solution uses Class instead of Module: that's totally acceptable at this stage. No reason to discuss.
* `scan` is faster than `split`
* It can be hard to catch all the possible delimiters. 
* `upcasing` the whole string is (10% ?) slower than `upcasing` the acronym only. 
* Store the regex in a constant or a variable, mostly so it can be named. 

## Passing Regular Expressions
`/\b[a-zA-Z]/` # only returns first letters, not `_` 

`\b[[:alpha:]]/` # same

`/\b\w/` # close enough; but it would return `_` as a first 'word character'

`/\b[[:word]]/` # same 

