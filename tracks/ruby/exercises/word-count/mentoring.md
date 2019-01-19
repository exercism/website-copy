### New Concepts
hash (new here because Robot Name has been removed as a core exercise); constant; `each_with_object`.

### Minimal solution for approval
```ruby
class WordCount
  WORD_REGEX = /\b[\w']+\b/

  def initialize(phrase)
    @phrase = phrase
  end

  def word_count
    words.each_with_object(Hash.new(0)) do | word, count |
      count[word] += 1
    end
  end

  private

  def words
    @phrase.downcase.scan(WORD_REGEX)
  end
end

```

### Reasonable Variants
- Using `reduce`/`inject` for the counting.

- An exceptionally nice solution uses `group_by(&:itself)`, and the `transform_values` method introduced in Ruby 2.4

  ```ruby
    def word_count
      words.group_by(&:itself).transform_values { |v| v.count }  
    end
  ```
  which can be even more elegant with `Symbol#to_proc`: `transform_values(&:count)` 

### General
- At this point in the track, students have had multiple opportunities to practive with avoiding the accumulator pattern (with a counter variable). 
- Solutions with `each`, `for` or others are not considered approvable.
- The RegEx gets complicated in the last test, where it should catch both `"large"` and `'large'` ` => { large: 2 }`. 
As long as they got something that catches a word with or without `'`, it's fine to give away the last step for free.  
http://www.rubular.com/ 

### Talking points

- Extracting the preparation of the input into a separate (private) method.
- `intermediate steps to strip quotes`: One strategy people use to catch quoted words is an intermediate step like 'strip_quotes'. Suggest to solve it within the RegEx. 
- Storing the RegEx in a Constant.
- The goal of separating the preparing of the input from the processing itself.
- Do's and don'ts in initializers.  

### Mentor Research 
Passing regular expressions:
- `/\b[\w']+\b/`
- `/\b[[:alnum]']+\b/`
- `/\b[[:word:]']+\b/`


