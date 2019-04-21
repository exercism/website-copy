### Reasonable solutions

#### Using Option.defaultValue

```fsharp
module TwoFer

let twoFer (input: string option): string = 
    input
    |> Option.defaultValue "you"
    |> sprintf "One for %s, one for me."
```

#### Using defaultArg

```fsharp
module TwoFer

let twoFer (input: string option): string =
    let who = defaultArg input "you"
    sprintf "One for %s, one for me." who
```

### Common suggestions

- Instead of using a `match` expression to work with the option value, suggest to use one of the functions in the `Option` module. Note: `Option.defaultValue` has not yet been documented.
- If string concatenation is used to build the string, remark that the customary way to format/build strings is to use the `sprintf` function. You can point to https://fsharpforfunandprofit.com/posts/printf/ for more information.
- If the student has two branches which both return a string, suggest to have them combine it into a single branch using one of the `Option` module's functions.

### Talking points
