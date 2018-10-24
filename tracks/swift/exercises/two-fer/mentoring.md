# Two Fer

_Two Fer_ is a core exercise, unlocked after _Hello World_.

## Reasonable Solutions

```swift
func twoFer(name: String = "you") -> String {
    return "One for \(name), one for me."
}
```

## Common suggestions

- Sometimes students will use optionals or even an empty default and check for
  the value to replace with `"you"` instead of just using `"you"` directly, e.g.
  ```swift
  func twoFer(name: String = "") -> String {
      if name == "" {
          return "One for you, one for me."
      }
      return "One for \(name), one for me."
  }
  ```
- Encourage string interpolation with `"\()"` instead of concatenation, e.g.
  `"One for " + name + ", one for me."`.
