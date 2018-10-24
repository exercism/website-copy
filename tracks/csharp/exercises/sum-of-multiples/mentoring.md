### Reasonable solutions
#### LINQ (Readable)

```csharp
using System.Collections.Generic;
using System.Linq;

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        return Enumerable.Range(1, max - 1)
            .Where(i => multiples.Any(m => i % m == 0))
            .Sum();
    }
}
```

#### LINQ (Performant)
By tweaking the algorithm we can get a more performant (albeit less readable)
version as follows:

```csharp
using System.Linq;
using System.Collections.Generic;

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
        => multiples.SelectMany(
            multiple => Enumerable.Range(1, (max - 1) / multiple).Select(numTimes => numTimes * multiple)
            , (numtimes, multiple) => multiple).Distinct().Sum();
}
```

#### Custom LINQ Method
An alternative that shows how you can roll your own LINQ methods to boost performance is below:
```csharp
using System.Collections.Generic;
using System.Linq;

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        return multiples.SelectMany(multiple => GenerateMultiples(multiple, max - 1, multiple))
          .Distinct().Sum();
    }

    public static IEnumerable<int> GenerateMultiples(int min, int max, int step)
    {
        // reversed direction to avoid int overflow
        for (int i = max / step * step; i >= min; i -= step)
        {
            yield return i;
        }
    }
}

```

#### Non-LINQ
If the student is not yet ready for / comfortable with full-on LINQ then something along the following lines would be appropriate:

```csharp
using System.Linq;
using System.Collections.Generic;

public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        var results = new HashSet<int>();
        foreach (var multiple in multiples)
        {
            // reversed direction to avoid int overflow
            for (int i = (max - 1) / multiple * multiple; i > 0; i -= multiple)
            {
                results.Add(i);
            }
        }

        return results.Sum();
    }
}
```

### Common suggestions

- There are dozens of equally valid LINQ constructions that can be used
of which 3 variations are provided above.
- Instead of using `List<int>` to gather the results use `HashSet<int>` for performance and clarity

### Talking points

- When it comes to performance, many submissions (including the first above) when run 
against a test such as `SumOfMultiples.Sum(new[] { 1_999_999_999 }, 2_000_000_000)` take minutes
rather than milliseconds.  This could be handled by making full use of `SelectMany`
 (_LINQ (Performant)_) or with a custom LINQ method (a variation
of `Enumerable.Range` which takes a step value) (_Custom LINQ Method_)
To handle large sets of multiples a more efficient algorithm may be required -
probably not of great interest to a csharp learner but perhaps worth mentioning.
- Submissions including the ones above are not robust in that they will fail for values
where large numbers of multiples are generated.  The "checked" modifier
can be mentioned to show how Sum() handles overflows and there may be scope
to position this earlier in the solution for a fast and more informative fail.  Alternatively long or perhaps
 BigInteger types can be employed to handle issues with values greater
 than int.MaxValue.
 - Not everyone likes them, but it might be useful to suggest writing the `SumOfMultiples` method (see _LINQ (Performant)_) as an [expression-bodied method](https://docs.microsoft.contm/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.


TODO a bullet proof solution for signed ints.