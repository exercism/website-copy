# Mentoring

### Reasonable Solutions

```ruby
class Scrabble
  LETTERS = [
    [%w(A E I O U L N R S T), 1],
    [%w(D G), 2],
    [%w(B C M P), 3],
    [%w(F H V W Y), 4],
    [%w(K), 5],
    [%w(J X), 8],
    [%w(Q Z), 10]
  ].flat_map { |letters, score|
    letters.map { |letter| [letter, score] }
  }.to_h
  private_constant :LETTERS

  def self.score(word)
    new(word).score
  end

  def initialize(letters)
    @letters = letters.to_s.strip.upcase.chars
  end

  def score
    letters.sum { |letter| LETTERS[letter] }
  end

  private
  attr_reader :letters
end
```

Some mentors also prefer a more complicated MultiKeyHash class:
```ruby
class Scrabble
  class MultiKeyHash
    def initialize(hash)
      @exploded = hash.reduce([]) do |arr, (letters, value)|
        arr + letters.product([value])
      end.to_h
    end

    def [](key)
      exploded[key]
    end

    private
    attr_reader :exploded
  end

  LETTERS = MultiKeyHash.new(
    %w[A E I O U L N R S T] => 1,
    %w[D G]                 => 2,
    %w[B C M P]             => 3,
    %w[F H V W Y]           => 4,
    %w[K]                   => 5,
    %w[J X]                 => 8,
    %w[Q Z]                 => 10
  )

  ...
```
