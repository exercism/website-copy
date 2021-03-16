# Mentoring

New concepts: Iterating over an array (preferably with `each_cons`, avoid `each_with_index`); `.chars` to split the string; (private) `attr_reader`; raising an Argument Error; inline if-statement; `unless` 

### Minimal solution for approval

```ruby

class Series
  def initialize(numerals)
    @numerals = numerals.chars
  end

  def slices(span)
    raise ArgumentError unless span <= numerals.size
    numerals.each_cons(span).map { |slice| slice.join }
  end

  private
  attr_reader :numerals
end
```

### Reasonable variants
- Do the splitting in the slices method: 
  ```ruby
    @numerals = numerals.chars
  ```
- For more advanced students favor `each_char` over `chars`. See details at the "Talking points".
- Ampersand syntax is a bonus point. `map(&:join)`.

### General 
- The Instructions point to a beginner friendly [explanation of iterating in Ruby:](http://jeromedalbert.com/ruby-how-to-iterate-the-right-way/)
and to the rubydocs [Enumerable](https://ruby-doc.org/core/Enumerable.html) with a hint that should make finding `each_cons` easier. 


### Talking points
- `each_cons` instead of an iterator `with_index`: In Ruby, you rarely have to write iterators that need to keep track of the index. Enumerable has powerful methods that do that for us.
- `chars`: instead of `split('')`.
- `each_char`: if an `Array` is not specifically necessary or wanted.
- `attr_reader`: instead of the instance variable, [explained here](https://ivoanjo.me/blog/2017/09/20/why-i-always-use-attr_reader-to-access-instance-variables).
- `private` attr_reader: Following the 'rule' for encapsulation: if it doesn't need to be public, make it private. [This link](http://ruby-for-beginners.rubymonstas.org/writing_classes/state_and_behaviour.html) may come in handy for a first introduction. 
- `unless`, inline: With `unless` instead of `if`, we can show what "good" looks like for the conditional statement.
- `error`: Custom error message? (Only if the first submission meets the Minimal Solution.)
- `map(&:join)`: instead of map with block, but at this point in the track it's okay to just accept it if students use it, no need to require it or dive into the subject of `Symbol#to_proc`.
- `each_char`: may be preferable over `chars` as it returns an `Enumerator` that will yield each character without creating an intermediate `Array`. More: `String#chars` with a block has a deprecation warning in more recent Ruby versions. `str.chars` is a shorthand for `str.each_char.to_a`.

### Mentor Research
- The Iteration article mentioned above isn't ideal, but it's one of the few I know of that does more than comparing `each` and `map`, PLUS don't uses hashes for examples.
Other suggestions welcome.
- `each_cons` raises an ArgumentError for arguments <= 0; it returns the array if the argument >= the array. 

### Changelog
- 2017 Jan: Changed from arrays of integers to arrays of strings.
- 2020 Sep: Added `each_char` over `chars`.
