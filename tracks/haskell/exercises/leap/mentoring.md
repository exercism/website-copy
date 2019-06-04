### Reasonable solutions

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year = year `mod` 4 == 0 && 
  (year `mod` 100 /= 0 || year `mod` 400 == 0)
```

Many students start out with this solution. Some leave out the parenthesis.

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year 
  | year `isDivisibleBy` 400 = True
  | year `isDivisibleBy` 100 = False
  | year `isDivisibleBy`   4 = True
  | otherwise                = False

isDivisibleBy :: Integer -> Integer -> Bool
isDivisibleBy x n = x `rem` n == 0
```

This solution uses guards and a helper predicate, `isDivisibleBy`.

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year 
  | year `rem`   4 /= 0 = False
  | year `rem` 100 /= 0 = True
  | year `rem` 400 /= 0 = False
  | otherwise           = True
```

This solution evaluates the three conditions in an optimal order.

```haskell
import Data.Time.Calendar (isLeapYear)
```

This solution assumes that `time` has been added as a dependency in package.yaml.

### Common suggestions

- See this as an opportunity to practice using guards to separate the three criteria.
- Simplify the three criteria as one guard each (not necessary to check both mod 4 and mod 100 when mod 400).
- The ``year `rem` n == 0`` pattern can be refactored by using a helper function
- Using `rem` instead of `mod` gives the same answer for positive numbers and is more efficient in the compiler
- Don't use if-then-else, but instead `&&`, `||` and `not`, or guards.

### Talking points
 
- Some students tend to write patterns like

```
if p then True else False
if p then False else True
if p then True else q
if p then q else False
```

  and so on. These can always be replaced by simpler expressions, or guards.

- Overuse of parentheses: Some change what's evaluated while others are redundant. This can be triggered by:
  - Not knowing the precedence rules of various operators, infixed functions and function application
  - A habit of assuming that parentheses are required when making function calls
  - Because they forgot to refactor them out before submitting.

- Lack of parentheses: Not having parentheses around ``year `mod` 100 /= 0 || year `mod` 400 == 0`` causes an unnecessary evaluation of ``year `mod` 400 == 0``. While this inefficiency is, in practice, insignificant, make sure that the student chose to disregard this *significant* parenthesis consciously.

- Students of Haskell may disagree which definition most closely resembles the problem statement and which focus to place on the exercise. As a mentor, placing emphasis on guards as a learning objective will have a payoff in coming exercises.
