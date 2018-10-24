### Reasonable solutions
#### LINQ

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

public static class Raindrops
{
    public static string Convert(int number)
    {
        var sounds = new Dictionary<int, string>()
        {
            [3] = "Pling",
            [5] = "Plang",
            [7] = "Plong",
        };

        var factors = sounds
            .Where(kv => number % kv.Key == 0)
            .Select(kv => kv.Value)
            .DefaultIfEmpty(number.ToString());

        return string.Join(string.Empty, factors);
    }
}
```

#### Extreme LINQ
```csharp
using System.Linq;

public static class Raindrops
{
    public static string Convert(int number)
        => new (string sound, int value)[] {("Pling", 3), ("Plang", 5), ("Plong", 7)}
            .Where(p => number % p.value == 0)
            .Select(p => p.sound)
            .DefaultIfEmpty(number.ToString())
            .Aggregate((sounds, sound) => sounds + sound);
}
```
#### Non-LINQ
```csharp
using System;

public static class Raindrops
{
    public static string Convert(int number)
    {
        var sound = string.Empty;

        if (number % 3 == 0) sound += "Pling";
        if (number % 5 == 0) sound += "Plang";
        if (number % 7 == 0) sound += "Plong";

        return string.IsNullOrEmpty(sound) ? number.ToString() : sound;
    }
}
```

### Common suggestions

- The non-LINQ solution presents an opportunity to mention the performance
advantages of `StringBuilder` in a more performance sensitive context.
- Again, for the non-LINQ solution, where the student has presented a switch
statement or multiple conditions, as above it can be worth mentioning the
virtues of a read only initialised dictionary.  This can morph into a 
discussion of a LINQ based solution.

### Talking points

- Where the solution repeats the raindrop numbers as literals it is worth
recommending the `const` construct, C#'s answer to the magic number issue.
- Is a terse solution necessarily easier to read or maintain than others?
- Some students in their enthusiasm for all things LINQ employ `Enumerable.Range()`
as the driver for the pipeline.  This is not efficient.