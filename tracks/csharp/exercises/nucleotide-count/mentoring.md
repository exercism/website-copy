### Reasonable solutions

#### Using a foreach loop

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

public static class NucleotideCount
{
    public static IDictionary<char, int> Count(string sequence)
    {
        var nucleotideCounts = new Dictionary<char, int> { {'A', 0}, {'C', 0}, {'G', 0}, {'T', 0} };

        foreach (var c in sequence)
        {
            if (nucleotideCounts.ContainsKey(c))
            {
                nucleotideCounts[c]++;
            }
            else
            {
                throw new ArgumentException("Invalid Nucleotide Symbol");
            }
        }

        return nucleotideCounts;
    }
}
```

#### Foreach with ToDictionary

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

public static class NucleotideCount
{
    private static readonly char[] ValidNucleotideSymbols = {'A', 'C', 'G', 'T'};

    public static IDictionary<char, int> Count(string sequence)
    {
        var nucleotideCounts = ValidNucleotideSymbols.ToDictionary(c => c, c => 0);

        foreach (var c in sequence)
        {
            if (ValidNucleotideSymbols.Contains(c))
            {
                nucleotideCounts[c]++;
            }
            else
            {
                throw new ArgumentException("Invalid Nucleotide Symbol");
            }
        }

        return nucleotideCounts;
    }
}
```

### Common Suggestions

As the README doesn't explicitly mention that a student should optimize for performance, don't discard solutions just on this ground. Rather, use it as a chance to start a discussion about readability/performance trade-offs and when to prefer which.

* If you look for a performance-oriented solution, iterating over the input string more than once wastes cycles, memory, etc. Often, it isn't obvious that this is happening because methods like `ToList`, `GroupBy` and `Count` will iterate over all the string's characters without the student having to write a loop.
  * Similarly, though there are numerous ways to use LINQ to solve this problem, it should be avoided in performance scenarios. All of them involve iterating the input string multiple times.

* If one wants to optimize for readability, using LINQ is probably the best approach.
