# Mentoring

## Reasonable Solutions

This problem hinges on how the scores are stored.
The most common approach is to use an object with properties for `win`, `loss`, `total_points`, and to calculate these on-the-fly.
Deferring the calculation by storing the scores in an array is a more concise approach:

```ruby
# Namespace for Exercism Ruby/Tournament problem
module Tournament
  # Contains team name and team-specific state, generates scores
  class Team
    extend Forwardable

    SCORING = {
      'win' => 3,
      'draw' => 1,
      'loss' => 0
    }.freeze

    def_delegator :@results, :<<
    attr_reader :name

    def initialize(name)
      @name = name
      @results = []
    end

    protected

    def matches_played
      @results.size
    end

    def wins
      @results.count('win')
    end

    def losses
      @results.count('loss')
    end

    def draws
      @results.count('draw')
    end

    def total_points
      @results.sum(&SCORING)
    end

    public

    def stats
      [name, matches_played, wins, draws, losses, total_points]
    end

    def <=>(other)
      [-total_points, name] <=> [-other.total_points, other.name]
    end
  end

  # convenience class which creates a Hash with a default value of an empty
  # Team object
  class Roster < Hash
    def initialize(*args, &block)
      if block_given?
        super
      else
        super { |hash, key| hash[key] = Team.new(key) }
      end
    end
  end

  # holds overall state of the tournament
  class Tournament
    RESULT_PAIRS = {
      'win' => 'loss',
      'loss' => 'win',
      'draw' => 'draw'
    }.freeze

    def initialize(matchdata)
      @teams = add_results(split_matches(matchdata))
    end

    private

    def split_matches(match_lines)
      match_lines.split("\n").flat_map do |match|
        home, away, result = match.split(';')
        [[home, result], [away, RESULT_PAIRS.fetch(result)]]
      end
    end

    def add_results(matches, roster = Roster.new)
      matches.each_with_object(roster) do |(team, result), memo|
        memo[team] << result
      end
    end

    public

    def scores
      @teams.values.sort.map(&:stats)
    end
  end

  TABLE = "%-30s | %2s | %2s | %2s | %2s | %2s\n"

  HEADINGS = %w[Team MP W D L P]

  def self.tally(matches)
    Tournament.new(matches).scores
      .unshift(HEADINGS)
      .map(&TABLE.method(:%))
      .join
  end
end
```

The naive approach forces a `case` statement to determine the number of points that are assigned for each result.
This is not necessarily wrong, and students who prefer using a class with explicit `win`, `loss` properties should be allowed to do so.

The methods above that split the matches can be easily combined:

```ruby
def add_matches(match_lines)
  match_lines.each_with_object(Roster.new) do |match, roster|
    home, away, result = match.split(';')
    roster[home] << result
    roster[away] << RESULT_PAIRS[result]
  end
end
```

There is no reason to prefer either approach.

## Common Suggestions

- There are a number of ways to implement sorting, and the method returning the statistics block from the `Team` object can return a `Hash` instead of an `Array` if the student prefers: this makes sorting using `sort_by` more pleasant.
  Using a `<=>` method is probably more flexible and idiomatic.
- Separating the `HEADINGS` from the table formatting allows for cleaner code.
- Separating purely presentational code from the data model is preferable.
  Making a `Team#to_s` method should be discouraged.
- Having a `Roster` class is not necessary, but the `each_with_object` line is much shorter if you do have it.

## Talking Points

Ruby is at its most powerful and expressive when the bulk of the problem logic is contained in `Enumerable` data structures.
This problem can be done as a "one-liner", but breaking it into stateful objects and constants makes it much more legible, and provides the foundation for a more complete application.
As much of the business logic as possible should be contained in the `Team` object.

Using `Forwardable` is not at all necessary, but the strategy of having a class that wraps an `Enumerable` data structure and exposes methods of that property is well worth knowing, and this is a good place to discuss it.

The Tournament class has little or no state of its own, and the `add_results` and `split_matches` methods operate on a `String` and `Array` respectively.
It is possible to convert those to singleton methods, or to use refinements to add them to `String` and `Array`, or to create another convenience class that wraps `String` and/or `Array`.
None of these options is particularly attractive, but it is probably worth some discussion of where the state and methods should be located, and how that might change if `Tournament` had broader responsibilities.

On some more minor points, the `method` method is very useful for tabulating the output, and summing the results array is an excellent place to use `Hash#to_proc` (see `Team#total_points` above).

Making the calculation/accessor methods on `Team` protected is probably a good excuse to talk about the difference between `protected` and `private` methods and properties.

## Changelog

- 2021 Nov - Markdown adjustment to style guide (sentences and links)
