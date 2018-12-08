### Reasonable solutions

 ```haskell
 isDivisibleBy :: Integer -> Integer -> Bool
 isDivisibleBy x n = x `rem` n == 0

 isLeapYear :: Integer -> Bool
 isLeapYear year 
     | year `isDivisibleBy` 400 = True
     | year `isDivisibleBy` 100 = False
     | year `isDivisibleBy`   4 = True
     | otherwise = False
 ```
### Common suggestions

Many students start out with something like
 
 ```haskell
 isLeapYear :: Integer -> Bool
 isLeapYear year = year `mod` 4 == 0 && 
                  (year `mod` 100 /= 0 || year `mod` 400 == 0)
 ```

Some suggestions would be
 
- Using guards makes the logic cleaner
- The ``year `mod` n == 0`` pattern can be factored by using a helper function
- Using `rem` instead of `mod` gives the same answer for positive numbers and is more efficient in the compiler
 
 A more advanced solution reverses the logic

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
 
 - `if then else` is over uneccessary
  - some students tend to write patterns like
  ```
  if p then True else False
  if p then False else True
  if p then True else q
  if p then q else False
  ```
- the over use of parentheses is something to watch. This can be triggered by
  - not knowing the precedence rules of various operators, infixed functions and function application
  - a habit of assuming that parentheses are required when making function calls
  - because they forgot to refactor them out before submitting.
