### Reasonable solutions

#### Using a list comprehension

```csharp
let accumulate func input = [ for x in input do yield func x ]
```

#### Using an accumulator function

```fsharp
let accumulate func input = 
    let rec aux acc =
        function
        | []    -> acc
        | x::xs -> aux (func x :: acc) xs
    
    aux [] input |> List.rev
```

### Common suggestions

- If the student doesn't use the `yield` keyword, suggest them to look into it.

### Talking points

- Per the restrictions in the [README](https://github.com/exercism/fsharp/blob/master/exercises/accumulate/README.md#restrictions), the student is not allowed to use `List.map`, `List.fold` or similar functions.

#### Tail recursion

It is not uncommon for students to write a recursive implementation. However, it is important to check that it is a tail-recursive implementation, as the implementation would otherwise throw a `StackOverflowException` for large inputs. You can refer them to [this page](https://blogs.msdn.microsoft.com/fsharpteam/2011/07/08/tail-calls-in-f/) for more information about tail-recursive functions.

