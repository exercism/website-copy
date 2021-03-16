# use null coalescing operator not is null or white space

Rather than using `string.IsNullOrWhiteSpace` to determine if the default name should be used, consider trying the [null-coalescing operator](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/null-coalescing-operator) to simplify the code and consider the difference in behaviour.
