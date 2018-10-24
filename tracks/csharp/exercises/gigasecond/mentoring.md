### Reasonable solutions

```csharp
using System;

public static class Gigasecond
{
    public static DateTime Add(DateTime birthDate)
    {
        return birthDate.AddSeconds(1e9);
    }
}
```

As an alternative, one could use an expression-bodied method:

```csharp
using System;

public static class Gigasecond
{
    public static DateTime Add(DateTime birthDate) => birthDate.AddSeconds(1e9);
}
```

### Common suggestions

- Replace `Math.Pow(10, 9)` with `1e9`.
- Replace `1000000000` with `1e9` or `1_000_000_000`.
- Use `AddSeconds()` instead of `Add()`.

### Talking points

- One could argue that the gigasecond value itself (`1e9` or similar), should be given its own, descriptive identifier. Note that this identifier cannot be named `Gigasecond`, as C# does not allow identifiers that have the same name as the enclosing type. An alternative name could be `OneGigasecond`, which should be a `const` field.
- Not everyone likes them, but it might be useful to suggest writing the `Add` method as an [expression-bodied method](https://docs.microsoft.contm/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.
