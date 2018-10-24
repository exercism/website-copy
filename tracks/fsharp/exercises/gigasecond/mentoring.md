### Reasonable solutions

```fsharp
module Gigasecond

open System

let add (birthDate: DateTime) = birthDate.AddSeconds(1e9)
```

### Common suggestions

- Replace `Math.Pow(10, 9)` or `1000000000.` with `1e9`.
- Use `AddSeconds()` instead of `Add()`.

### Talking points

- One could argue that the gigasecond value itself (`1e9` or similar), should be given its own, descriptive identifier.https://docs.microsoft.contm/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as it is perfect for these kinds of small methods.
