### Reasonable solutions

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year = year `mod` 4 == 0 && 
                 (year `mod` 100 /= 0 || year `mod` 400 == 0)
```
is a common solution that follows the logic and passes the tests.

### Common suggestions

- The `year `mod` n == 0` pattern can be factored by using a helper function
- Using `rem` instead of `mod` gives the same answer for positive numbers and is more efficient in the compiler

```haskell
isDivisibleBy :: Integer -> Integer -> Bool
isDivisibleBy x n = rem x n == 0
```

- Using guards makes the logic cleaner

```haskell
isLeapYear :: Integer -> Bool
isLeapYear year 
    | year `isDivisibleBy` 400 = True
    | year `isDivisibleBy` 100 = False
    | year `isDivisibleBy`   4 = True
    | otherwise = False
```
and this can be reversed to match the common logic solution

```haskell
isNotDivisibleBy :: Integer -> Integer -> Bool
isNotDivisibleBy x n = rem x n /= 0

isLeapYear :: Integer -> Bool
isLeapYear year 
    | year `isNotDivisibleBy`   4 = False
    | year `isNotDivisibleBy` 100 = True
    | year `isNotDivisibleBy` 400 = False
    | otherwise = True
```

### Talking points
- `if then else` is over elaborate
- the over use of parentheses is something to watch
