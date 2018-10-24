### Reasonable solutions

#### Using LINQ

```csharp
using System;
using System.Linq;

public static class Hamming
{
    public static int Distance(string strand1, string strand2)
    {
        if (strand1.Length != strand2.Length)
        {
            throw new ArgumentException("Strands have different length");
        }

        return strand1.Zip(strand2, (nucleotide1, nucleotide2) => nucleotide1 == nucleotide2 ? 0 : 1).Sum();
    }
}
```

#### Using a for-loop

```csharp
using System;

public static class Hamming
{
    public static int Distance(string strand1, string strand2)
    {
        if (strand1.Length != strand2.Length)
        {
            throw new ArgumentException("Strands have different length");
        }

        var distance = 0;

        for (var i = 0; i < strand1.Length; i++)
        {
            if (strand1[i] != strand2[i])
            {
                distance++;
            }
        }

        return distance;
    }
}
```

As an alternative, one could use the ternary operator to replace the if-statement in the loop:

```csharp
for (var i = 0; i < strand1.Length; i++)
{
    distance += strand1[i] == strand2[i] ? 0 : 1;
}
```

### Common suggestions

- Don't use `ToCharArray()` to iterate over the individual characters, as the string class itself already implements `IEnumerable<char>`.

### Talking points

#### Fail fast

Some students structure their solution such that the exception is thrown at the bottom of the method:

```csharp
public static int Distance(string strand1, string strand2)
{
    if (strand1.Length == strand2.Length)
    {
        ...
    }
    else
    {
        throw new ArgumentException("Strands have different length");
    }
}
```

Suggest that it might be useful to have the exceptional case handled first, as this is usually how C# methods are structured: error-handling first, than the regular implementation.

The non-LINQ approach is almost twice as fast as the LINQ approach for long strands (say 1 billion letters)
