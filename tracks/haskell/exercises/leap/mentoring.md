# Mentoring

### Reasonable solutions

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year = year `mod` 4 == 0 && 
  (year `mod` 100 /= 0 || year `mod` 400 == 0)
```

Many students submit this solution. Some leave out the parenthesis.

Some place the parenthesis inefficiently, causing an unnecessary `mod` 400 check.

Some place unnecessarily many parentheses.

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year =
  if year `rem` 100 == 0
  then year `rem` 400 == 0
  else year `rem` 4 == 0

isLeapYear :: Integer -> Bool
isLeapYear year =
  let divBy n = year `rem` n == 0
  in if divBy 100 then divBy 400 else divBy 4
```

Many students will use if-then-else, but often where the branches are `True` or `False`.

Some students introduce a helper predicate. Sometimes they inherit `year`, sometimes not.

Some variations of if-then-else seem defensible, and many others are too verbose.

```haskell
isLeapYear year 
  | year `isDivisibleBy` 400 = True
  | year `isDivisibleBy` 100 = False
  | year `isDivisibleBy`   4 = True
  | otherwise                = False

isDivisibleBy :: Integer -> Integer -> Bool
isDivisibleBy x n = x `rem` n == 0
```

Some students explore the use of guards.

Some uses of guards in this exercise are questionable.

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year
  | year `rem` 100 == 0 = year `rem` 400 == 0
  | otherwise           = year `rem` 4 == 0
```

This solution mirrors the if-then-else solution at the cost of optimal evaluation order.

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year 
  | year `rem`   4 /= 0 = False
  | year `rem` 100 /= 0 = True
  | year `rem` 400 /= 0 = False
  | otherwise           = True
```

This solution evaluates the three conditions in an optimal order at the cost of readability.

Since guards may be introduced to improve readability, this solution seems a little counterproductive.

```haskell
import Data.Time.Calendar (isLeapYear)
```

This solution assumes that `time` has been added as a dependency in package.yaml.

### Common suggestions

- This can be seen as an opportunity to practice using guards to separate the
  three criteria. If so, avoid solutions that simply provide one guard and an
  `otherwise`:

  ```haskell
  isLeapYear :: Integer -> Bool
  isLeapYear year
    | year `mod` 4 == 0 && (year `mod` 100 /= 0 || year `mod` 400 == 0) = True
    | otherwise = False
  ```

  ... as nothing is gained from the use of guards here. Some variations with
  fewer than one guard per criterium have defensible goals, e.g. wanting to
  avoid literal `True` and `False`:

  ```haskell
  isLeapYear :: Integer -> Bool
  isLeapYear year
    | year `mod` 100 == 0 && year `mod` 400 == 0 = True
    | year `mod` 100 /= 0 && year `mod` 400 == 0 = False
    | otherwise = year `mod` 4 == 0
  ```

  This strategy tries to avoid to depend on the order of evaluating guards, but
  checks the predicate multiple times.  Perhaps here it is better to revert to
  if-then-else, or split the guards into one per predicate, or use some other
  solution strategy.

- The ``year `rem` n == 0`` pattern can be refactored by using a helper function
- Using `rem` instead of `mod` gives the same answer for positive integers, but uses [fewer instructions](https://hackage.haskell.org/package/base/docs/src/GHC.Real.html#divMod).
- When using `&&`, `||` and `not`, consider simplifying to the recommended solution.
- When using guards, consider if the solution is deemed more readable.
- When using if-then-else, literal `True` or `False` suggests simplification is possible.

### Talking points
 
- Some students tend to write patterns like

  ```
  if p then True else False
  if p then False else True
  if p then True else q
  if p then q else False
  ```

  and so on. These can always be replaced by simpler expressions, or guards. (For example: The expression `if p then q else False` can and should be replaced by the equivalent expression `p && q`.)

- Overuse of parentheses: Some change what's evaluated while others are redundant. This can be triggered by:
  - Not knowing the precedence rules of various operators, infixed functions and function application
  - A habit of assuming that parentheses are required when making function calls
  - Because they forgot to refactor them out before submitting.

- Lack of parentheses: Not having parentheses around ``year `mod` 100 /= 0 || year `mod` 400 == 0`` causes an unnecessary evaluation of ``year `mod` 400 == 0``. While this inefficiency is, in practice, insignificant, make sure that the student chose to disregard this *significant* parenthesis consciously.

- Students of Haskell may disagree which definition most closely resembles the problem statement and which focus to place on the exercise. As a mentor, placing emphasis on guards as a learning objective will have a payoff in coming exercises, but it is not essential.
