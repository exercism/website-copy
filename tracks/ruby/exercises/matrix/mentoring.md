# Mentoring

## Reasonable Solutions

```ruby
class Matrix
  attr_reader :rows, :columns

  def initialize(matrix_as_string)
    @rows = extract_rows(matrix_as_string)
    @columns = rows.transpose
  end

  private

  def extract_rows(string)
    string.each_line.map { |line| line.split.map(&:to_i) }
  end
end
```

Many solutions will not split out the input parsing into methods like this.
We don't yet have consensus among mentors if this is important or not.
If the methods are split out, then they should be private.

```ruby
class Matrix
  def initialize(matrix_as_string)
    @matrix_as_string = matrix_as_string
  end

  def rows
    @rows ||= @matrix_as_string.each_line.map { |line| line.split.map(&:to_i) }
  end

  def columns
    @columns ||= rows.transpose
  end
end
```

Separate methods are also permissible rather than doing all the work upfront in `initialize`.

## Common Suggestions

There is no need to overload a student with all of these suggestions, so here is a list ordered roughly by most important suggestions first:

- Suggest the student look at other methods on `String` that could simplify their code if they don't use `String#lines` or `String#each_line`
- If they have written their own transpose method, point out `Array#transpose`
- More generally, for any solutions that has matching based on a regular expression or explicitly declared string or substring, encourage them to find a solution that does not require either
- If the solution is reasonable, then approve it, but suggest that they might want to attempt to write their own version of `Array#transpose`.

## Changelog

- 2021 Nov - Markdown adjustment to style guide (sentences and links)
