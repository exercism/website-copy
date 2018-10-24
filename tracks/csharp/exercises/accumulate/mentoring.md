### Reasonable solutions

#### Using yield

```csharp
using System;
using System.Collections.Generic;

public static class AccumulateExtensions
{
    public static IEnumerable<U> Accumulate<T, U>(this IEnumerable<T> collection, Func<T, U> func)
    {
        foreach (var element in collection)
        {
            yield return func(element);
        }
    }
}
```

#### Storing the results in an intermediate list

```csharp
using System;
using System.Collections.Generic;

public static class AccumulateExtensions
{
    public static IEnumerable<U> Accumulate<T, U>(this IEnumerable<T> collection, Func<T, U> func)
    {
        var accumulated = new List<U>();

        foreach (var element in collection)
        {
            accumulated.Add(func(element));
        }

        return accumulated;
    }
}
```

### Common suggestions

- If the student doesn't use the `yield` keyword, suggest them to look into it.

### Talking points

- Per the restrictions in the [README](https://github.com/exercism/csharp/blob/master/exercises/accumulate/README.md#restrictions), the student is not allowed to use LINQ's `Select()` method.


