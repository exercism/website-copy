### Reasonable solutions

This solution is good for teaching people about primes if they're manually working them out: 

```ruby
require 'prime'

module Raindrops
  SOUNDS = {3 => "Pling", 5 => "Plang", 7 => "Plong"}.freeze

  def self.convert(num)
    factors = num.prime_division.map(&:first)
    rhythm = factors.map {|f| SOUNDS[f] }.compact.join
    rhythm.empty? ? num.to_s : rhythm
  end
end
```

This is the optimal solution:
```ruby
module Raindrops
  SOUNDS = {3 => "Pling", 5 => "Plang", 7 => "Plong"}.freeze

  def self.convert(num)
    rhythm = SOUNDS.select{|key, sound| num % key == 0}.values
    rhythm.empty? ? num.to_s : rhythm.join
  end
end
```

### Common suggestions
- Using the `prime` library rather than manually calculating
- Using `select`.
- Not needing `("")` on the `join`
