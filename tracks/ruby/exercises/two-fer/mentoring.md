### Intro
This is the first core exercise. Great opportunity to prepare for the track with attention to style conventions. 

### Reasonable solutions

```ruby
class TwoFer
  def self.two_fer(name = 'you')
    "One for #{name}, one for me."
  end
end
```

### Common suggestions
- Suggest using a default value instead of any form of conditionals. 
- People often set the default of `name` to `nil`. Ask if there is something they could do with the default value to avoid the conditional and make their code simpler.
- Suggest to remove `return`
- Use `def` with parentheses, because of the parameter.
- Check if the BookKeeper module is present and the comment removed.
- Some people need help with running the tests. 
- Check indentation (convention is 2-space indentation).

### Talking points
- Implicit returns
- Default values
- String interpolation (http://ruby-for-beginners.rubymonstas.org/bonus/string_interpolation.html)
- Style preferences. This exercise is a good opportunity to talk about style conventions like indentation, parameter parenthesis in method declarations and removing redundant comments. 
https://github.com/rubocop-hq/ruby-style-guide
Given the place in the curriculum, it may be worth to not going to deep, and to not addressing points that are controversial or personal preference. 

### Mentoring notes
- A friendly standard answer about how this can be done in one line, and a 'hint: use a different default value' to get rid of the conditionals, will be all you need for maybe 90% of the submissions. 
- Most mentors seem to ignore the use of either `self.two_fer` or `class << self`. That is appropriate to where we are in the track. 
- Every now and then there is a submission that makes TwoFer a module instead of a class.

