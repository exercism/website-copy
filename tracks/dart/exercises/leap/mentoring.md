# Mentoring

## Reasonable solutions

### Single expression

```dart
class Leap {
  bool leapYear(int year) =>
      year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
}
```

### Using a helper function

```dart
class Leap {
  bool leapYear(int year) {
    final isDivisibleBy = (int n) => year % n == 0;

    return isDivisibleBy(4) && !isDivisibleBy(100) || isDivisibleBy(400);
  }
}
```    

### Common suggestions

- Instead of using several, potentially nested if-statement, suggest to remove the if-statements by returning a single expression using the boolean `&&` and `||` operators.
- Instead of explicitly returning `true` or `false` (e.g. `if x then true else false`), suggest to simply return the boolean condition (`x`).
- If students are doing more than three checks in their if-statement, ask if they could get it down to just three checks. You could give them a hint to following the instructions in the README : 
```
a year MUST be a multiple of four AND NOT be a multiple of 100
a year MUST be a multiple of 400 (implies multiple of 4 and 100)
```

### Talking points

- Students often use parentheses, but as the `&&` operator has a higher precedence than the `||` operator, this is not necessary. You can check that in the [Dart Lang Specification](https://dart.dev/guides/language/specifications/DartLangSpec-v2.2.pdf) at section **20.2 - Operator Precedence**.

## Solution Video

Step by step [video][youtube-video] guide solution for this exercise

[youtube-video]: https://www.youtube.com/watch?v=Uluen1tvKwU&t=5s
