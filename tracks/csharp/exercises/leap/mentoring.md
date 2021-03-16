# Mentoring

## Reasonable solutions

```csharp
using System;

public static class Leap
{
    public static bool IsLeapYear(int year)
    {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    }
}
```

As an alternative, one could use an expression-bodied method:

```csharp
using System;

public static class Leap
{
    public static bool IsLeapYear(int year)
        => year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
}
```

## Common suggestions

- Instead of using several, potentially nested if-statement, suggest to remove the if-statements by returning a single expression using the boolean `&&` and `||` operators.
- Instead of explicitly returning `true` or `false` (e.g. `if (x) return true else return false`), suggest to simply return the boolean condition (`return x`).
- If students are doing more than three checks in their if-statement, ask if they could get it down to just three checks. You could give them a hint to following the instructions in the README. There are only two cases that return true:
  - a year MUST be a multiple of four AND NOT be a multiple of 100
  - a year MUST be a multiple of 400 (implies multiple of 4 and 100)
- The _order of operation_ and _evaluation_ matter, see talking points:
  - A student might be missing parentheses:
    ```csharp
    return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
    ```
    Albeit correct in output, the check `year % 400` is executed for all years that don't match `year % 4 == 0`, and for these (75% of all years), always returns `false`, because if something is not divisible by 4 it _can not_ be divisible by 400. This is making a redundant check.
  - A student might have inversed the test order:
    ```csharp
    return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0);
    ```
    Albeit correct in output, the check `year % 400` is _only_ true for `1.03%` years that are divisible by 4. Always try to put the common path first. Logically, following the instructions putting this check first is **incorrect**.

## Talking points
- _order of operation_ matters:
  - 75% of all years *cannot* be leap years because they are not multiples of 4; test `year % 4 == 0` first
  - 98.97% of all leap years are multiples of 4 that are not multiples of 100; test `year % 100 != 0` second
  - 1.03% of all leap years are multiples of 4 that are also multiples of 100 and 400; test `year % 400 == 0` third
- _order of evaluation_ matters: Refer to [Operator precedence](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/#conditional-and-operator). In C# logical AND (`&&`) always goes before logical OR (`||`). Adding parentheses clears up any confusion, and groups the second and third test together.
- Not everyone likes them, but it might be useful to suggest writing the `IsLeapYear` method as an [expression-bodied method](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.
