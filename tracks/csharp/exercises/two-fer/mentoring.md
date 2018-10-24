### Reasonable solutions

The most simple solution is to change the default value from `null` to `"you"` and use string interpolation:

```csharp
public static class TwoFer
{
    public static string Name(string name = "you")
    {
        return $"One for {name}, one for me.";
    }
}
```

As an alternative, one could use an expression-bodied method:

```csharp
public static string Name(string name = "you") => $"One for {name}, one for me.";
```

An alternative solution would be to use the [null-coalescing operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/null-coalescing-operator):

```csharp
public static class TwoFer
{
    public static string Name(string name = null)
    {
        return $"One for {input ?? "you"}, one for me.";
    }
}
```

As an alternative, one could use an expression-bodied method:

```csharp
public static string Name(string input = null) => $"One for {input ?? "you"}, one for me.";
```

### Common suggestions

- Instead of using an if-statement, consider using a single expression. This will force the student to remove any duplication in the code.
- Suggest using [string interpolation](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/tokens/interpolated) over string contatenation, `string.Format` or `StringBuilder` approaches.
- It is not uncommon for students to put parentheses within the interpolated variable (like `{(input ?? "you")}`. These can safely be removed.
- If they are using the approach where the default value is changed to `"you"`, check if they have also change the parameter name to something more descriptive than `input`.

### Talking points

- Many solutions re-assign the input parameter (e.g. `if (input == null) input = "you";`). While there is technically nothing wrong with this, you could suggest not to re-use the parameter but instead introduce a new variable. This has the main benefit of keeping things immutable: by not overwriting the parameter value, you know its value on every single line in the method: namely its original value. This greatly helps in figuring out the state of a system.
- Not everyone likes them, but it might be useful to suggest writing the `Add` method as an [expression-bodied method](https://docs.microsoft.contm/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.
- Microsoft Code Quality article CA1026 strongly discourages the use of optional parameters in publicly
facing methods.  Kudos to Thiez for pointing this out.  In addition to the cross-language issues raised
in the article this is also a case (similar to public `const`s) where the explicit code contract can be
modified by the callee without the caller's being aware.