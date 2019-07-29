### Reasonable solutions

#### without using `LINQ` 

```csharp
using System;

public static class Isogram
{
    public static bool IsIsogram(string word)
    {
        // Ignore spaces, hyphens, regard uppercase as lower.
        string trimmedInput = word.Trim().Replace(" ", "").Replace("-", "").ToLower();
        foreach (char c in trimmedInput)
        {
            if (trimmedInput.IndexOf(c) != trimmedInput.LastIndexOf(c))
                return false;
        }

        return true;
    }
}
```

#### using `LINQ`

```csharp
using System.Linq;

public static class Isogram
{
    public static bool IsIsogram(string word)
    {
        // Ignore spaces, hyphens, regard uppercase as lower.
        string trimmedInput = word.Trim().Replace(" ", "").Replace("-", "").ToLower();
        return trimmedInput.Count(c => trimmedInput.Count(b => b == c) <= 1) == trimmedInput.Length;
    }
}
```

### Common suggestions

- In the non LINQ version, try to use a single loop

- The Replace could be potentially improved (either using regular expressions or LINQ via Split and Aggregate. But due to the fact there are only 2 chars to be replaced, it may take longer, and maybe suboptimal to write in a different way.
    
### Talking points

