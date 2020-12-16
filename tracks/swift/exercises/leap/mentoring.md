_Leap_ is a core exercise, unlocked after _Two Fer_.

### Reasonable Solutions

```swift
struct Year {
    let isLeapYear: Bool

    init(calendarYear year: Int) {
        isLeapYear = year.isMultiple(of: 4) && (!year.isMultiple(of: 100) || year.isMultiple(of: 400))
    }
}
```

### Common Suggestions

- Swift 5 includes `Int.isMultiple(of:)`. ([SE-0225](https://github.com/apple/swift-evolution/blob/master/proposals/0225-binaryinteger-iseven-isodd-ismultiple.md))
- For previous versions, we can extend the language ourselves and refactoring the divisibility check to an internal function, or an extension:
  
```
extension Int {
    func isDivisibleBy(_ n: Int) -> Bool {
        return self % n == 0
    }
}
```
  
- It may be more readable to return the results of boolean expressions, instead
  of explicit `true` or `false` (see example below).

#### Prefer immutability over mutability

Given the following solution

```swift 
class Year {
    var calendarYear: Int
    var isLeapYear: Bool
    
    init(calendarYear: Int) {
        self.calendarYear = calendarYear;
        
        self.isLeapYear = ((calendarYear % 4 == 0) && (calendarYear % 100 != 0) || (calendarYear % 400 == 0));
    }
}
```
Below Code breaks
```swift
let year = Year(calendarYear:2004)
year.isLeapYear // this is true, 
// Since it is class i can mutate its value
year.calendarYear = 2009
year.isLeapYear // this is still true
```

The issue above can be fixed by changing `var` to `let`:
```swift
let calendarYear: Int
```
So I would suggest to start the code with `let` and `struct`.

### Talking Points

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

