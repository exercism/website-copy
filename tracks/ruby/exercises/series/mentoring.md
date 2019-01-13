New concepts: Iterating over an array (preferably with `each_cons`, avoid `each_with_index`); `.chars` to split a string; `attr_reader`; `private` (for the attr_reader); raising an Argument Error; inline if-statement 

### Minimal solution for approval

```ruby

class Series

  def initialize(serie)
    @serie = serie
  end

  def slices(span)
    raise ArgumentError if span > serie.size
    serie.chars.each_cons(span).map {|slice| slice.join}
  end

  private
  attr_reader :serie
end
```

### Reasonable variants
 - `Proc.to_sym` for the joining ( `map(&:join)` ), but at this point in the track just allow it if students use it, don't ask for it.  

### General 
- The Instructions point to a beginner friendly [explanation of iterating in Ruby:](http://jeromedalbert.com/ruby-how-to-iterate-the-right-way/)
and to the rubydocs [Enumerable](https://ruby-doc.org/core/Enumerable.html) with a hint that should make finding `each_cons` easier. 


### Talking points
- `each_cons` instead of an iterator `with_index`: In Ruby, you rarely have to write iterators that need to keep track of the index. Enumerable has powerful methods that does that for us.
- `chars`: Use Ruby's built-in methods instead of implementing it yourself: `chars` instead of `split('')`   
- `attr_reader`: instead of the instance variable (Explained here:)[https://ivoanjo.me/blog/2017/09/20/why-i-always-use-attr_reader-to-access-instance-variables]
- `private` attr_reader: Following the 'rule' for encapsulation: if it doesn't need to be public, make it private. [This link](http://ruby-for-beginners.rubymonstas.org/writing_classes/state_and_behaviour.html) may come in handy for a first introduction. 
- `inline if statement`
- `error`: Custom error message? (Only if the first submission meets the Minimal Solution.)

### Mentor Research
- The Iteration article mentioned above isn't ideal, but it's one of the few I know of that does more than comparing `each` and `map`, PLUS don't uses hashes for examples.
Other suggestions welcome.
- `each_cons` raises an ArgumentError for arguments <= 0; it returns the array if the argument >= the array. 

### Changelog
- 2017 Jan: Changed from arrays of integers to arrays of strings.
