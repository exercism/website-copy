# Mentoring

## Reasonable solutions

```ruby
def isogram?(string)
  letters = string.downcase.scan(/[a-z]/)
  letters.uniq.length == letters.length
end
```

## Common suggestions

- Suggest using [`scan`][String#scan] rather than `gsub` as it removes the need to break the string into chars.

## Talking points

- Comparing lengths (`letters.uniq.length == letters.length`) is **marginally** quicker than comparing letters (`letters.uniq == letters`) but its more code.
  Which is better?

## Changelog

- 2021 Nov - Markdown adjustment to style guide (sentences and links)

[String#scan]: https://ruby-doc.org/core-2.2.0/String.html#method-i-scan
