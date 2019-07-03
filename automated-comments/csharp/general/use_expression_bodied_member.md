As the `%{name}` method only has a single statement, consider converting the method to an [expression-bodied method](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods).

Note that it can be good for readability to have an expression-bodied method span multiple lines:

```csharp
public string Transform(string input) =>
    input.Trim()
        .ToLowerCase()
        .Substring(0, 10)
        .Replace("yes", "no");
```
