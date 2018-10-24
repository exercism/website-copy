### Reasonable solutions

```ruby
class Squares
  def initialize(last)
    @last = last
  end

  def difference
    square_of_sum - sum_of_squares
  end

  def square_of_sum
    natural_numbers.sum.abs2
  end

  def sum_of_squares
    natural_numbers.sum(&:abs2)
  end

  private
  attr_reader :last

  def natural_numbers
    1.upto(last)
  end
end
```

### Talking points
- `sum` with and without a block (Ruby 2.4+) 
- `1.upto(last)` vs `1..last` 
- How to square? 
  `** 2`, `abs2` or `pow(2)` (`Integer#pow` was introduced in Ruby 2.5.0) 
- Extract the range into a private method or define the range in the constructor?
- Use `attr_reader` and make it `private`. 
  
