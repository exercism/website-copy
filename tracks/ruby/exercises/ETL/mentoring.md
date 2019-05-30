_ETL_ is a mid level side exercise, unlocked by WordCount (in PR xxx).

### Minimal Solution for Approval


```ruby 
class ETL

  def self.transform(source)
    source.each_with_object({}) do |(score, letters), destination|
      letters.each do |letter| 
        destination[letter.downcase] = score
      end  
    end
  end
end
```

### Variants
A more functional approach is as approvable.

```ruby
source.flat_map do |score, letters|
      letters.map do |letter|
        [letter.downcase, score]
      end
    end.to_h
```
OR using `Array#product`:

```ruby
source.flat_map {|score,letters| letters.map(&:downcase).product([score]) }.to_h
```

### Mentoring Strategy
- Unless the student starts with a functional approach, focus on `each_with_object`.    

### Common suggestions
- Add a suggestion https://ruby-doc.org/core-2.2.0/String.html#method-i-scan

### Talking points
- Decompose array in block variables

### Mentor Research Notes

### Changelog

- Test data version: xxx

