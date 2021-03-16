# Mentoring

### Reasonable solutions

The most simple solution is to set the default value for the parameter to `"you"` and use string interpolation:

```csharp
public static class TwoFer
{
    public static string Speak(string name = "you")
    {
        return $"One for {name}, one for me.";
    }
}
```

As an alternative, one could use an expression-bodied method:

```csharp
public static string Speak(string name = "you") => $"One for {name}, one for me.";
```

An alternative solution would be to use set the default value to `null` and use the [null-coalescing operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/null-coalescing-operator):

```csharp
public static class TwoFer
{
    public static string Speak(string name = null)
    {
        return $"One for {input ?? "you"}, one for me.";
    }
}
```

As an alternative, one could use an expression-bodied method here too:

```csharp
public static string Speak(string input = null) => $"One for {input ?? "you"}, one for me.";
```

### Common suggestions

- If they are using overloaded methods, suggest to use a single method with an optional parameter.
- Instead of using an if-statement, suggest to use a single expression. This will force the student to remove any duplication in the code.
- Suggest using [string interpolation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/interpolated) over string contatenation, `string.Format` or `StringBuilder` approaches.
- If they are using `null` as the default value, suggest to use `"you"` instead.

### Talking Suggestions

- Many solutions re-assign the name parameter (e.g. `if (name == null) name = "you";`). While there is technically nothing wrong with this, you could suggest not to re-use the parameter but instead introduce a new variable. This has the main benefit of keeping things immutable: by not overwriting the parameter value, you know its value on every single line in the method: namely its original value. This greatly helps in figuring out the state of a system.
- Not everyone likes them, but it might be useful to suggest writing the `Speak` method as an [expression-bodied method](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.
