### Reasonable solutions

### Using a foreach loop

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

public static class NucleotideCount
{
    public static IDictionary<char, int> Count(string sequence)
    {
        var result = new Dictionary<char, int> { {'A', 0}, {'C', 0}, {'G', 0}, {'T', 0} };
        
        foreach (var c in sequence)
        {
            if (result.ContainsKey(c)) result[c]++;
            else throw new ArgumentException("Invalid Nucleotide Symbol");
        }

        return result;
    }
}
```

### Foreach with ToDictionary

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

public static class NucleotideCount
{
    private static readonly char[] ValidNucleotideSymbols = {'A', 'C', 'G', 'T'};
    
    public static IDictionary<char, int> Count(string sequence)
    {
        var result = ValidNucleotideSymbols.ToDictionary(c => c, c => 0);
        
        foreach (var c in sequence)
        {
            if (ValidNucleotideSymbols.Contains(c)) result[c]++;
            else throw new ArgumentException("Invalid Nucleotide Symbol");
        }

        return result;
    }
}
```

### Common Suggestions

 * Iterating over `sequence` more than once wastes cycles, memory, etc. Often it isn't obvious that this is happening because methods like `ToList`, `GroupBy` or `OrderBy` will iterate a list without the student having to write a loop.
   * Hence, using `sequence.Any()` or `sequence.Where(...)` to implement the exception is wrong. It should be thrown within the single iteration.
   * Similarly, though there are numerous ways to use LINQ to solve this problem it should be avoided. All of them involve iterating `sequence` multiple times.