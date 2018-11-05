### Reasonable solutions

#### Array.Reverse

```csharp
using System;

public static class ReverseString
{
    public static string Reverse(string input)
    {
        var characters = input.ToCharArray();
        Array.Reverse(characters);
        return new string(characters);
    }
}
```

#### Reverse for-loop

```csharp
using System.Text;

public static class ReverseString
{
    public static string Reverse(string input)
    {
        var reversedString = new StringBuilder();

        for (var i = input.Length - 1; i >= 0; i--)
        {
            reversedString.Append(input[i]);
        }

        return reversedString.ToString();
    }
}
```

#### LINQ Reverse()

```csharp
using System.Linq;

public static class ReverseString
{
    public static string Reverse(string input)
    {
        return new string(input.Reverse().ToArray());
    }
}
```

As an alternative, one could use an expression-bodied method:

```csharp
using System.Linq;

public static class ReverseString
{
    public static string Reverse(string input) => new string(input.Reverse().ToArray());
}
```

### Common suggestions

- Some students iterate over the string's characters by using `ToCharArray()`. Suggest that they can iterate directly over the string, as it implements `IEnumerable<char>`.

### Talking points
