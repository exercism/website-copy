### Reasonable solutions

#### Using LINQ

```csharp
using System.Linq;

public static class Bob
{
    public static string Response(string message)
    {
        if (IsSilence(message)) 
            return "Fine. Be that way!";

        if (IsYell(message) && IsQuestion(message))
            return "Calm down, I know what I'm doing!";
        
        if (IsYell(message))
            return "Whoa, chill out!";
        
        if (IsQuestion(message))
            return "Sure.";
        
        return "Whatever.";
    }

    private static bool IsQuestion(string message)
        => message.TrimEnd().EndsWith("?");

    private static bool IsYell(string message)
        => message.Any(char.IsLetter) && message.ToUpperInvariant() == message;

    private static bool IsSilence(string message)
        => string.IsNullOrWhiteSpace(message);
}
```

As an alternative, one could define the helper methods as extension methods:

```csharp
using System.Linq;

public static class Bob
{
    public static string Response(string message)
    {
        if (message.IsSilence()) 
            return "Fine. Be that way!";

        if (message.IsYell() && message.IsQuestion())
            return "Calm down, I know what I'm doing!";
        
        if (message.IsYell())
            return "Whoa, chill out!";
        
        if (message.IsQuestion())
            return "Sure.";
        
        return "Whatever.";
    }

    private static bool IsQuestion(this string message)
        => message.TrimEnd().EndsWith("?");

    private static bool IsYell(this string message)
        => message.Any(char.IsLetter) && message.ToUpperInvariant() == message;

    private static bool IsSilence(this string message)
        => string.IsNullOrWhiteSpace(message);
}
```

#### Using regular expressions

```csharp
using System.Text.RegularExpressions;

public static class Bob
{
    public static string Response(string message)
    {
        if (IsSilence(message))
            return "Fine. Be that way!";

        if (IsYell(message) && IsQuestion(message))
            return "Calm down, I know what I'm doing!";

        if (IsYell(message))
            return "Whoa, chill out!";

        if (IsQuestion(message))
            return "Sure.";

        return "Whatever.";
    }

    private static bool IsQuestion(string message)
        => Regex.IsMatch(message, @"\?\s*$");
    private static bool IsYell(string message)
        => Regex.IsMatch(message, "[A-Z]") && !Regex.IsMatch(message, "[a-z]");

    private static bool IsSilence(string message)
        => Regex.IsMatch(message, @"^\s*$");
}
```

### Common suggestions

- If the yelling and question logic is duplicated, suggest to extract the functionality to a well-named helper method.
- If one determines the last character using index-based logic (`message[message.Length - 1]`), suggest to use one of the `string` class' built-in methods (`EndsWith()`).
- If regular expressions are used, suggest to consider a combination of LINQ and built-in methods.
- Instead of using `Trim()`, suggest to use `TrimEnd()`, as only the whitespace at the end of the string should be trimmed.
- Instead of using nested if-statement, suggest to use the fact that `return` results in an immediate return from the method.
- Helper methods or variables are often named for _how_ they are implemented (e.g. `var endsWithQuestion = ...` or `var emptyOrWhiteSpace = ...`). Suggest to name these methods/variable for _what_ they represent, using the vocabulary of this exercise's domain (e.g. `var isQuestion` or `var isSilence`).

### Talking points

- It is not uncommon for students to use variables to prevent the yelling or question logic from being executed more than once. While this is a valid point, performance is not critical in Exercism.
- Not everyone likes them, but it might be useful to suggest writing the helper methods as [expression-bodied methods](https://docs.microsoft.contm/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.
