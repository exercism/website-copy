### Reasonable Solutions

```ruby
class Luhn
  def self.valid?(*args)
    new(*args).valid?
  end

  def valid?
    return false if id_code =~ NOT_NUMERIC_OR_SPACE
    return false if digits.length < MINIMUM_DIGITS

    total.modulo(10).zero?
  end

  private
  attr_reader :id_code
  def initialize(id_code)
    @id_code = id_code
  end

  def total
    digits.reverse.each_slice(2).sum do |dig_1, dig_2 = 0|
      dig_1 + (dig_2 * 2).divmod(10).sum
    end
  end

  def digits
    id_code.delete(" ").each_char.map(&:to_i)
  end

  NOT_NUMERIC_OR_SPACE = /[^0-9 ]/
  MINIMUM_DIGITS = 2
  private_constant :NOT_NUMERIC_OR_SPACE, :MINIMUM_DIGITS
end
```

### Talking points

- Use of `sum` enumerator
- Use of `divmod(10).sum`
- Use of the default paramater for the second digit in `sum`
