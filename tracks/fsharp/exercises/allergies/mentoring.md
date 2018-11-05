### Reasonable solutions

#### Using an enum

```fsharp
module Allergies

open System

type Allergen =
   | Eggs         = 0b00000001
   | Peanuts      = 0b00000010
   | Shellfish    = 0b00000100
   | Strawberries = 0b00001000
   | Tomatoes     = 0b00010000
   | Chocolate    = 0b00100000
   | Pollen       = 0b01000000
   | Cats         = 0b10000000

let private allergens =
    Enum.GetValues(typeof<Allergen>) 
    |> Seq.cast<Allergen>
    |> Seq.toList

let allergicTo codedAllergies allergen = codedAllergies &&& int allergen <> 0

let list codedAllergies = List.filter (allergicTo codedAllergies) allergens
```

#### Using a discriminated union

```fsharp
module Allergies

type Allergen =
   | Eggs
   | Peanuts
   | Shellfish
   | Strawberries
   | Tomatoes
   | Chocolate
   | Pollen
   | Cats

let private allergens = [Eggs; Peanuts; Shellfish; Strawberries; Tomatoes; Chocolate; Pollen; Cats]

let private allergenMask allergen = 
    match allergen with
    | Eggs         -> 0b00000001
    | Peanuts      -> 0b00000010
    | Shellfish    -> 0b00000100
    | Strawberries -> 0b00001000
    | Tomatoes     -> 0b00010000
    | Chocolate    -> 0b00100000
    | Pollen       -> 0b01000000
    | Cats         -> 0b10000000

let allergicTo codedAllergies allergen = codedAllergies &&& (allergenMask allergen) <> 0

let list codedAllergies = List.filter (allergicTo codedAllergies) allergens
```

### Common suggestions

- If the student is using a discriminated union, such to look into using an enum. This will allow the masks to be encoded as the enum value. For more information, you can refer to [this page](https://fsharpforfunandprofit.com/posts/enum-types/).
- If the student is hard-coding the list of enum allergens, suggest to look at `Enum.GetValues`.\

### Talking points

#### Binary literals

Instead of defining the masks using their integer values (`1`, `2`, `4`, etc.), one can also use binary literals. This has the advantage that the bitwise-masking structure is made visual, especially when doing some careful aligning of the values:

```fsharp
| Eggs         = 0b00000001
| Peanuts      = 0b00000010
| Shellfish    = 0b00000100
```


