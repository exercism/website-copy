### Reasonable solutions

```fsharp
let reverse (input: string): string = input |> Seq.rev |> Seq.toArray |> System.String
```

### Common suggestions

- Should a student submit an imperative version (using a for-loop), suggest to try a functional approach.
- Some students iterate over the string's characters by using `ToCharArray()`. Suggest that they can iterate directly over the string, as it implements `IEnumerable<char>`.

### Talking points
