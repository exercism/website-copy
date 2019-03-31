### Reasonable solutions

```ruby
module Raindrops
  def self.convert(integer)
    result = +'' # This is what allows '' to be mutable, ie., Ruby 2.6
    result << 'Pling' if (integer % 3).zero?
    result << 'Plang' if (integer % 5).zero?
    result << 'Plong' if (integer % 7).zero?
    result << integer.to_s if result.empty?
    result
  end
end
```

```ruby
module Raindrops
  RULES = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }

  def self.convert(integer)
    sounds = RULES.each_with_object(+'') do |(divisor, sound), result|
      result << sound if (integer % divisor).zero?
    end
    sounds.empty? ? integer.to_s : sounds
  end
end
```

```ruby
module Raindrops
  SOUNDS = {3 => "Pling", 5 => "Plang", 7 => "Plong"}.freeze

  def self.convert(num)
    rhythm = SOUNDS.select{|key, _| (num % key).zero? }
    rhythm.empty? ? num.to_s : rhythm.values.join
  end
end
```

### Common suggestions

- Using the `prime` library rather than manually calculating doesn't make sense if we consider that prime is only suggested via examples given, but not by specification, as the specification stated is "factors".
- Using `select`.
- Not needing `("")` on the `join`
