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

- In the non LINQ version, try to use a single loop

- When using LINQ, the following suggestions can be made:
  * each element of the string should be a letter (in this way we avoid checking for space or '-')
  * without making any iteration, _distinct_ method helps to enforce the letter uniqueness, and find the isogram   
    
### Talking points
