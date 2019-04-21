# Gigasecond

_Gigasecond_ is a core exercise, unlocked after _Leap_.

## Reasonable Solution

```swift
import Foundation

struct Gigasecond {
    private static let formatter: DateFormatter = {
      let dateFormatter = DateFormatter()
      dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
      return dateFormatter
    }()

    let description: String

    init?(from: String) {
        guard let date = Gigasecond.formatter.date(from: from) else {
            return nil
        }

        let giga: TimeInterval = 1_000_000_000
        let gigaDate = date.addingTimeInterval(giga)
        description = Gigasecond.formatter.string(from: gigaDate)
    }
}
```

## Common Suggestions

- Students may not utilize the failable initializer for its _ability to fail_.
  That is, it may simply assign internal properties and never return `nil`.
- Students may attempt to use the force-unwrap operator `!` to get to the
  expected formatted date description. Encourage other approaches as this is
  considered "unsafe".
- Underscores can help readability for larger number literals (`1_000_000_000`).

## Talking Points

- `DateFormatter`s are actually relatively expensive (students can read more
  [here](http://jordansmith.io/performant-date-parsing/)). Keep an eye out
  for repeated instantiation, especially if used in a computed property.
