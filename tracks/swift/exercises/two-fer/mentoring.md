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
- Some students would wrap the `twoFer` function into another type and make it a `static` or `class` function:
  ```swift
  class TwoFer {
    static func twoFer(name: String = "") -> String {
      //...
    }
  ```
  It will pass the test cases. However, the class name `TwoFer` shadows the module name in test cases. There is no need to introduce a class here. Just making the function as a top-level one would make things simpler.
