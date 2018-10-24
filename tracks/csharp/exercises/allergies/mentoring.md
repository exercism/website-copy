### Reasonable solutions

#### Using LINQ to dynamically calculate the allergies

```csharp
using System;
using System.Linq;

[Flags]
public enum Allergen
{
    Eggs         = 1 << 0,
    Peanuts      = 1 << 1,
    Shellfish    = 1 << 2,
    Strawberries = 1 << 3,
    Tomatoes     = 1 << 4,
    Chocolate    = 1 << 5,
    Pollen       = 1 << 6,
    Cats         = 1 << 7
}

public class Allergies
{
    private readonly int mask;

    public Allergies(int mask) => this.mask = mask;

    public bool IsAllergicTo(Allergen allergen) => (mask & (int)allergen) != 0;

    public Allergen[] List()
        => Enum.GetValues(typeof(Allergen))
            .Cast<Allergen>()
            .Where(IsAllergicTo)
            .ToArray();
}
```

#### Using LINQ with precalculated values

```csharp
using System;
using System.Collections.Generic;
using System.Linq;

[Flags]
public enum Allergen
{
    Eggs         = 1 << 0,
    Peanuts      = 1 << 1,
    Shellfish    = 1 << 2,
    Strawberries = 1 << 3,
    Tomatoes     = 1 << 4,
    Chocolate    = 1 << 5,
    Pollen       = 1 << 6,
    Cats         = 1 << 7
}

public class Allergies
{
    private readonly Allergen[] allergies;

    public Allergies(int mask)
    {
        this.allergies = Enum.GetValues(typeof(Allergen))
            .Cast<Allergen>()
            .Where(allergen => (mask & (int)allergen) != 0)
            .ToArray();
    }

    public bool IsAllergicTo(Allergen allergen) => allergies.Contains(allergen);

    public Allergen[] List() => allergies;
}
```

### Common suggestions

- Instead of manually iterating over allergies, suggest to use LINQ.
- The `List()` method should use the `IsAllergicTo()` method in its implementation, to prevent duplication of logic.
- The list of allergies can be created using `Enum.GetValues(typeof(Allergen))`, which does require a type cast to be able to work with it.
- Although not strictly necessary, it is good practice to decorate the `Allergen` enumeration with the `[Flags]` attribute, to indicate that it can hold multiple values at once.
- When storing the `mask` constructor parameter as a field, that field can be made `readonly` as it will never change.

### Talking points

- One could pre-compute the allergies in the constructor, to possibly improve performance when its methods are called a lot.

#### Defining the bitmask

The enum is basically a glorified bit mask. This means that the enum's values all correspond to a byte with one bit set. There are several ways to do this:

##### Using bitwise shifting:

```csharp
[Flags]
public enum Allergen
{
    Eggs         = 1 << 0,
    Peanuts      = 1 << 1,
    Shellfish    = 1 << 2,
    Strawberries = 1 << 3,
    Tomatoes     = 1 << 4,
    Chocolate    = 1 << 5,
    Pollen       = 1 << 6,
    Cats         = 1 << 7
}
```

##### Using binary literals:

```csharp
[Flags]
public enum Allergen
{
    Eggs         = 0b00000001,
    Peanuts      = 0b00000010,
    Shellfish    = 0b00000100,
    Strawberries = 0b00001000,
    Tomatoes     = 0b00010000,
    Chocolate    = 0b00100000,
    Pollen       = 0b01000000,
    Cats         = 0b10000000
}
```

##### Using hex values:

```csharp
Flags]
public enum Allergen
{
    None         = 0x0,
    Eggs         = 0x1,
    Peanuts      = 0x2,
    Shellfish    = 0x4,
    Strawberries = 0x8,
    Tomatoes     = 0x10,
    Chocolate    = 0x20,
    Pollen       = 0x40,
    Cats         = 0x80
}
```

##### Using integer values:

```csharp
[Flags]
public enum Allergen
{
    Eggs         = 1,
    Peanuts      = 2,
    Shellfish    = 4,
    Strawberries = 8,
    Tomatoes     = 16,
    Chocolate    = 32,
    Pollen       = 64,
    Cats         = 128
}
```
