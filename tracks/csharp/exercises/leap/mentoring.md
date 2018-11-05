### Reasonable solutions

```csharp
using System;

public static class Leap
{
    public static bool IsLeapYear(int year)
    {
        return year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
    }
}
```

As an alternative, one could use an expression-bodied method:

```csharp
using System;

public static class Leap
{
    public static bool IsLeapYear(int year)
        => year % 4 == 0 && year % 100 != 0 || year % 400 == 0;
}
```

### Common suggestions

- Instead of using several, potentially nested if-statement, suggest to remove the if-statements by returning a single expression using the boolean `&&` and `||` operators.
- Instead of explicitly returning `true` or `false` (e.g. `if (x) return true else return false`), suggest to simply return the boolean condition (`return x`).
- If students are doing more than three checks in their if-statement, ask if they could get it down to just three checks. You could give them a hint to following the instructions in the README.

### Talking points

- Students often use parentheses, but as the `&&` operator has a [higher precedence]((https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/#conditional-and-operator)) than the `||` operator, this is not necessary.
- Not everyone likes them, but it might be useful to suggest writing the `IsLeapYear` method as an [expression-bodied method](https://docs.microsoft.contm/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.
