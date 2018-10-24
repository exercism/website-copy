# Leap

_Leap_ is a core exercise, unlocked after _Two Fer_.

## Reasonable Solutions

```swift
struct Year {
    let isLeapYear: Bool

    init(calendarYear year: Int) {
        isLeapYear = year.isDivisibleBy(4) && (!year.isDivisibleBy(100) || year.isDivisibleBy(400))
    }
}

extension Int {
    func isDivisibleBy(_ n: Int) -> Bool {
        return self % n == 0
    }
}
```

## Common Suggestions

- Consider refactoring the divisibility check to an internal function, or an
  extension (as shown above).
- It may be more readable to return the results of boolean expressions, instead
  of explicit `true` or `false` (see example below).

## Talking Points

- If initializing a `struct` or `class` based on a `let` property, is a computed
  property necessary? It will recompute the result even though the value never
  changes. E.g.
```swift
struct Year {
    private let year: Int

    init(calendarYear: Int) {
        self.year = calendarYear
    }

    // re-computed on every call, but internal `year` never changes
    var isLeapYear: Bool {
        // nested calls could be simplified by just returning
        // the results (i.e. `return !(year % 100 == 0) || year % 400 == 0`)
        if year % 4 == 0 {
            if year % 100 == 0 {
                return false
            } else if year % 400 == 0 {
                return true
            }
            return false
        }
        return false
    }
}
```
