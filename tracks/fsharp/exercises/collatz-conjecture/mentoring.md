### Reasonable solutions

```fsharp
let steps number = 
    let rec helper count current =
        match current with
        | _ when current < 1 -> 
            None
        | 1 -> 
            Some count
        | _ when current % 2 = 0 ->
            helper (count + 1) (current / 2)
        | _ ->
            helper (count + 1) (current * 3  + 1)

    helper 0 number
```

### Common suggestions

- If students are using mutable state, encourage them to try to write a functional, immutable version.

### Talking points

#### Tail recursion

It is not uncommon for students to write a recursive implementation. However, it is important to check that it is a tail-recursive implementation, as the implementation would otherwise throw a `StackOverflowException` for large inputs. You can refer them to [this page](https://blogs.msdn.microsoft.com/fsharpteam/2011/07/08/tail-calls-in-f/) for more information about tail-recursive functions.
