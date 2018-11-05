### Reasonable solutions

#### Using Seq.sumBy

```fsharp
module Hamming

let distance (strand1: string) (strand2: string): int option = 
    if strand1.Length <> strand2.Length then
        None
    else    
        Seq.zip strand1 strand2
        |> Seq.sumBy (fun (n1, n2) -> if n1 = n2 then 0 else 1)
        |> Some
```

#### Using Seq.fold

```fsharp
module Hamming

let distance (strand1: string) (strand2: string): int option = 
    if strand1.Length <> strand2.Length then
        None
    else    
        Seq.zip strand1 strand2
        |> Seq.fold (fun acc (n1, n2) -> if n1 = n2 then acc else acc + 1) 0
        |> Some
```

### Common suggestions

- If they are not using `Seq.zip`, suggest to look into it.
- If a solution manually traverses through the strings, suggest to use one of the default sequence traversal functions (such as `Seq.fold`).
- Instead of doing a combination of `Seq.filter .. |> Seq.length`, suggest to look at `Seq.sumBy`.

### Talking points
