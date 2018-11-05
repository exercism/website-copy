### Reasonable solutions

#### Single expression

```fsharp
module Leap

let leapYear (year: int): bool = year % 4 = 0 && year % 100 <> 0 || year % 400 = 0
```

As an alternative, one could lose the type annotations:

```fsharp
module Leap

let leapYear year = year % 4 = 0 && year % 100 <> 0 || year % 400 = 0
```

#### Using a helper function

```fsharp
module Leap

let leapYear year = 
    let isDivisibleBy n = year % n = 0

    isDivisibleBy 4 && not (isDivisibleBy 100) || isDivisibleBy 400
```    

### Common suggestions

- Instead of using several, potentially nested if-statement, suggest to remove the if-statements by returning a single expression using the boolean `&&` and `||` operators.
- Instead of explicitly returning `true` or `false` (e.g. `if x then true else false`), suggest to simply return the boolean condition (`x`).
- If students are doing more than three checks in their if-statement, ask if they could get it down to just three checks. You could give them a hint to following the instructions in the README.

### Talking points

- Students often use parentheses, but as the `&&` operator has a [higher precedence]((https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/#conditional-and-operator)) than the `||` operator, this is not necessary.
