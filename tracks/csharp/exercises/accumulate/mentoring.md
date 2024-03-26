# Mentoring

## Reasonable solutions

### Using yield

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

### Storing the results in an intermediate list

Solutions that don't use the `yield` keyword such as the following one which stores the results in an intermediate list *don't* pass the laziness test. The accumulate execution must be deferred until `ToList()` is called on it, which is tested with the `Accumulate_is_lazy` method.

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

- Per the restrictions in the [README](https://github.com/exercism/csharp/blob/main/exercises/accumulate/README.md#restrictions), the student is not allowed to use LINQ's `Select()` method.


