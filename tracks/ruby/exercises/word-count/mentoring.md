### Intro
Side exercise. Great to step up from basic loops and `Enumerable#each` to more powerful Enumberable methods. 

### Reasonable solutions
```ruby
class WordCount
  WORD_REGEX = /\b[\w|']+\b/

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

An exceptionally nice solution uses `group_by(&:itself)`, and the `transform_values` method introduced in Ruby 2.4

```ruby
def word_count
  words.group_by(&:itself).transform_values { |v| v.count }  
end

```
which can be even more elegant with symbol-to-proc: `transform_values(&:count)` 



### Common suggestions 
- [Minimal Viable Solution] For the counting, solutions with `each_with_object`, `reduce`/`inject` and `group_by` are acceptable approaches. 
Iterations with `each`, `for` or others with separate counters are not.
- The RegEx gets complicated in the last test, where it should catch both `"large"` and `'large'` ` => { large: 2 }`. 
As long as they got something that catches a word with or without `'`, you can give away the last step for free.  
http://www.rubular.com/ 
- [Minimal Viable Solution] Extracting the preparation of the input into a separate method.
- One strategy people use to catch quoted words is an intermediate step like 'strip_quotes'. 
Suggest to solve it within the RegEx. 

### Talking points
- Why the above mentioned solutions are preferred over iterations with separate counters.
- Storing the RegEx in a Constant.
- Public and Private Interface.
- The goal of separating the preparing of the input from the processing itself.
- Do's and don'ts in initializers.  
- Making RegEx's readable.

### Passing RegEx's
- `/\b[\w']+\b/`
- `/\b[[:alnum]']+\b/`
- `/\b[[:word:]']+\b/`


