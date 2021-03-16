# Mentoring

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
using System;
using System.Linq;

public static class Isogram
{
    public static bool IsIsogram(string word)
    {
        // Ignore spaces, hyphens, regard uppercase as lower.
        var trimmedInput = word.ToLower().Where(Char.IsLetter).ToCharArray();
        return trimmedInput.Distinct().Count() == trimmedInput.Length;
    }
}
```

### Common suggestions

- In the non-LINQ version, try to use a single loop.

- When using LINQ, the following suggestions can be made:
  * To make things easier, try only processing the string's letters (in this way we avoid checking for spaces or '-').
  * Suggest using the `Distinct()` method to help calculate the uniqueness of the letters.
